# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "markked/version"

Gem::Specification.new do |s|
  s.name        = "markked"
  s.version     = Markked::VERSION
  s.authors     = ["Cole"]
  s.email       = ["thecatwasnot@gmail.com"]
  s.homepage    = "http://marked.li"
  s.summary     = %q{marked.li irc bot of doom}
  s.description = %q{Handy, dandy, helper bot.}

  s.rubyforge_project = "markked"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "cinch"
  s.add_runtime_dependency "twitter"
end
