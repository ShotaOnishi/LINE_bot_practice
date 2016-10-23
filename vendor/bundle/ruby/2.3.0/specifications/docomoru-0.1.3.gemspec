# -*- encoding: utf-8 -*-
# stub: docomoru 0.1.3 ruby lib

Gem::Specification.new do |s|
  s.name = "docomoru".freeze
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Ryo Nakamura".freeze]
  s.date = "2015-03-31"
  s.email = ["r7kamura@gmail.com".freeze]
  s.executables = ["docomoru".freeze]
  s.files = ["bin/docomoru".freeze]
  s.homepage = "https://github.com/r7kamura/docomoru".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.7".freeze
  s.summary = "Client library for docomo API written in Ruby.".freeze

  s.installed_by_version = "2.6.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<faraday>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<faraday_middleware>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<json>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<rack>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<slop>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_development_dependency(%q<codeclimate-test-reporter>.freeze, ["= 0.4.4"])
      s.add_development_dependency(%q<rake>.freeze, ["= 10.4.2"])
      s.add_development_dependency(%q<rspec>.freeze, ["= 3.2.0"])
      s.add_development_dependency(%q<rubocop>.freeze, ["= 0.29.1"])
      s.add_development_dependency(%q<webmock>.freeze, ["= 1.20.4"])
    else
      s.add_dependency(%q<activesupport>.freeze, [">= 0"])
      s.add_dependency(%q<faraday>.freeze, [">= 0"])
      s.add_dependency(%q<faraday_middleware>.freeze, [">= 0"])
      s.add_dependency(%q<json>.freeze, [">= 0"])
      s.add_dependency(%q<rack>.freeze, [">= 0"])
      s.add_dependency(%q<slop>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_dependency(%q<codeclimate-test-reporter>.freeze, ["= 0.4.4"])
      s.add_dependency(%q<rake>.freeze, ["= 10.4.2"])
      s.add_dependency(%q<rspec>.freeze, ["= 3.2.0"])
      s.add_dependency(%q<rubocop>.freeze, ["= 0.29.1"])
      s.add_dependency(%q<webmock>.freeze, ["= 1.20.4"])
    end
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 0"])
    s.add_dependency(%q<faraday>.freeze, [">= 0"])
    s.add_dependency(%q<faraday_middleware>.freeze, [">= 0"])
    s.add_dependency(%q<json>.freeze, [">= 0"])
    s.add_dependency(%q<rack>.freeze, [">= 0"])
    s.add_dependency(%q<slop>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
    s.add_dependency(%q<codeclimate-test-reporter>.freeze, ["= 0.4.4"])
    s.add_dependency(%q<rake>.freeze, ["= 10.4.2"])
    s.add_dependency(%q<rspec>.freeze, ["= 3.2.0"])
    s.add_dependency(%q<rubocop>.freeze, ["= 0.29.1"])
    s.add_dependency(%q<webmock>.freeze, ["= 1.20.4"])
  end
end
