# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "payment_gen/version"

Gem::Specification.new do |s|
  s.name        = "payment_gen"
  s.version     = PaymentGen::VERSION
  s.authors     = ["Yves Senn"]
  s.email       = ["yves.senn@garaio.com"]
  s.homepage    = ""
  s.summary     = %q{generate DTA-files according to the SIX specification}
  s.description = %q{the specification can be found at: www.currency-iso.org/DE/dl_tkicch_dta.pdf}

  s.rubyforge_project = "payment_gen"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
