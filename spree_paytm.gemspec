# coding: utf-8
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'solidus_paytm/version'
Gem::Specification.new do |s|
  s.platform              = Gem::Platform::RUBY
  s.name                  = 'solidus_paytm'
  s.version               = SolidusPaytm::VERSION
  s.summary               = 'Paytm integration into solidus application.'
  s.description           = s.summary
  s.required_ruby_version = '>= 2.1.0'

  s.author    = 'Monika Khatri'
  s.email     = 'monika.khatri.d@gmail.com'
  s.homepage  = 'https://github.com/samadimsys/solidus-paytm'

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'solidus_core', '~> 2.8.2'
end
