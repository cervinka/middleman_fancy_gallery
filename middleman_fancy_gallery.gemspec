# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'middleman_fancy_gallery/version'

Gem::Specification.new do |spec|
  spec.name          = "middleman_fancy_gallery"
  spec.version       = MiddlemanFancyGallery::VERSION
  spec.authors       = ["Petr Cervinka"]
  spec.email         = ["petr@petrcervinka.cz"]
  spec.summary       = %q{Add fancybox2 support for middleman.}
  spec.description   = %q{Add fancybox2 support for middleman.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
