# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{hal}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nicolas Sanguinetti"]
  s.date = %q{2010-06-27}
  s.email = %q{hi@nicolassanguinetti.info}
  s.extra_rdoc_files = ["README"]
  s.files = ["spec", "lib/hal", "lib/hal/rails.rb", "lib/hal/version.rb", "lib/hal.rb", "README"]
  s.homepage = %q{http://github.com/foca/hal}
  s.rdoc_options = ["--main", "README"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Simple and minimal authorization framework for ruby}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
