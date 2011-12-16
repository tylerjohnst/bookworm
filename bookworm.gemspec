# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "bookworm"
  s.version     = "0.1.2"
  s.authors     = ["Tyler Johnston"]
  s.email       = ["tylerjohnst@gmail.com"]
  s.homepage    = "http://github.com/tylerjohnst/bookworm"
  s.summary     = %q{ISBN/EAN manipulation, conversion, and inspection for Ruby.}
  s.description = %q{Convert from 13 digit EAN to 10 digit ISBN, from new to used, and back again. Detect used and new addendum in ISBN strings.}

  s.rubyforge_project = "bookworm"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
end
