# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "pipeweed"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Folker Bernitt"]
  s.email       = ["folker-bernitt-github@gmx.de"]
  s.summary     = %q{Pipeweed - Remote deployment with dependencies}
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.extra_rdoc_files = [
    "README.md"
  ]
  

  s.add_dependency(%q<net-ssh>, "~>2.6.3")
  s.add_dependency(%q<docile>, "~>1.0.1")
  s.add_dependency(%q<rspec>)  
  s.add_dependency(%q<mocha>, "~>0.13.2")

end
