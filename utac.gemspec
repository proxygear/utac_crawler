# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "utac/version"

Gem::Specification.new do |s|
  s.name        = "utac"
  s.version     = Utac::VERSION
  s.authors     = ["Benoit Molenda"]
  s.email       = ["benoit.molenda@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{a Ruby crawler to browse http://www.utac-otc.com/ centers}
  s.description = %q{crawler interface for http://www.utac-otc.com/ control centers}

  s.rubyforge_project = "utac"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_dependency 'httparty' #, :git => 'git://github.com/jnunemaker/httparty.git'
  s.add_dependency 'nokogiri'
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
