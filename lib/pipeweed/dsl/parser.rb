require 'pipeweed/dsl/repository'
require 'pipeweed/dsl/service'
require 'pipeweed/dsl/host'

require 'rgl/adjacency'
require 'rgl/dot'

module Pipeweed
  class Dsl
    class Parser

      def initialize
        @config = Config.new
        @load_paths = ["."]
      end

      class Config
        attr_reader :repositories, :services, :hosts
        
        def initialize
          @repositories = Hash[]
          @services = Hash[]
          @hosts = Hash[]
        end
      end

      def init_config_thread_local
        Thread.current[:pipeweed_parser_config] = @config
      end

      def load_default_recipe
        init_config_thread_local
        %w(Pipeweed pipeweed).each do |file|
          if File.file?(file)
            options = load_from_file(file)          
            instance_eval(options[:string], options[:name] || "<eval>")
          end
        end
        show_graph
      end
      
      def show_graph
        dg=RGL::DirectedAdjacencyGraph[]
        @config.services.each do |name, s|
          s.depends_on.each do |dep|
            dg.add_edge("#{s.class.name.split('::').last}:#{name}", "#{dep.class.name.split('::').last}:#{dep.name}")
          end
        end
        puts dg.to_s
        puts dg.write_to_graphic_file('jpg')

      end

      def load_from_file(file, name=nil)
        file = find_file_in_load_path(file) unless File.file?(file)
        Hash[:string => File.read(file), :name => name || file]
      end

      def find_file_in_load_path(file)
        load_paths.each do |path|
          ["", ".rb"].each do |ext|
            name = File.join(path, "#{file}#{ext}")
            return name if File.file?(name)
          end
        end

        raise LoadError, "no such file to load -- #{file}"
      end
      
      def repository(name, &block)
        repo = Pipeweed::Dsl.create_repository(&block)
        repo.name = name
        @config.repositories[name] = repo
        repo
      end

      def service (name, &block)
        s = Pipeweed::Dsl.create_service(&block)
        s.name = name
        @config.services[name] = s
        s
      end

      def host (name, &block)
        h = Pipeweed::Dsl.create_host(&block)
        h.name = name
        @config.hosts[name] = h
        h
      end
      
      class ConfigAccessor 
        def self.config
           Thread.current[:pipeweed_parser_config] 
        end
      end
      
      class Service < ConfigAccessor
        def self.[](key)
          raise ArgumentError, "no service with name #{key}" unless config.services.has_key?(key)
          config.services[key]
        end
      end
      
      class Repository < ConfigAccessor
        def self.[](key)
          raise ArgumentError, "no repository with name #{key}" unless config.repositories.has_key?(key)
          config.repositories[key]
        end
      end
      
      class Host < ConfigAccessor
        def self.[](key)
          raise ArgumentError, "no host with name #{key}" unless config.repositories.has_key?(key)
          config.hosts[key]
        end
      end
      
    end
  end
end