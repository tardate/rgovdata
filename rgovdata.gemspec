# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rgovdata}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Paul Gallagher"]
  s.date = %q{2011-10-31}
  s.default_executable = %q{rgd}
  s.description = %q{Consuming government-published data in a ruby or rails application shouldn't require a PhD}
  s.email = %q{gallagher.paul@gmail.com}
  s.executables = ["rgd"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rvmrc",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "bin/rgd",
    "lib/rgovdata.rb",
    "lib/rgovdata/catalog.rb",
    "lib/rgovdata/catalog/catalog.rb",
    "lib/rgovdata/catalog/registry_strategy/internal_registry.rb",
    "lib/rgovdata/catalog/registry_strategy/registry_strategy.rb",
    "lib/rgovdata/config.rb",
    "lib/rgovdata/config/config.rb",
    "lib/rgovdata/config/yaml_config.rb",
    "lib/rgovdata/data/config_template.yml",
    "lib/rgovdata/data/sg/registry.yml",
    "lib/rgovdata/data/template.rb",
    "lib/rgovdata/data/us/registry.yml",
    "lib/rgovdata/service.rb",
    "lib/rgovdata/service/csv_service.rb",
    "lib/rgovdata/service/listing.rb",
    "lib/rgovdata/service/odata_service.rb",
    "lib/rgovdata/service/service.rb",
    "lib/rgovdata/shell/shell.rb",
    "lib/rgovdata/version.rb",
    "rgovdata.gemspec",
    "spec/fixtures/config.yml",
    "spec/fixtures/us/eqs7day-M1.csv",
    "spec/spec_helper.rb",
    "spec/support/mocks.rb",
    "spec/support/utility.rb",
    "spec/unit/catalog/base_spec.rb",
    "spec/unit/catalog/registry_strategy_spec.rb",
    "spec/unit/config/config_spec.rb",
    "spec/unit/config/yaml_config_spec.rb",
    "spec/unit/data/template_spec.rb",
    "spec/unit/service/listing_spec.rb",
    "spec/unit/shell/shell_spec.rb"
  ]
  s.homepage = %q{http://github.com/tardate/rgovdata}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.2}
  s.summary = %q{Really simple access to government data for ruby}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, ["= 3.0.7"])
      s.add_runtime_dependency(%q<ruby_odata>, ["~> 0.0.10"])
      s.add_runtime_dependency(%q<getoptions>, ["~> 0.3"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.11"])
      s.add_development_dependency(%q<rake>, ["~> 0.9.2.2"])
      s.add_development_dependency(%q<rspec>, ["~> 2.7.0"])
    else
      s.add_dependency(%q<rails>, ["= 3.0.7"])
      s.add_dependency(%q<ruby_odata>, ["~> 0.0.10"])
      s.add_dependency(%q<getoptions>, ["~> 0.3"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<rdoc>, ["~> 3.11"])
      s.add_dependency(%q<rake>, ["~> 0.9.2.2"])
      s.add_dependency(%q<rspec>, ["~> 2.7.0"])
    end
  else
    s.add_dependency(%q<rails>, ["= 3.0.7"])
    s.add_dependency(%q<ruby_odata>, ["~> 0.0.10"])
    s.add_dependency(%q<getoptions>, ["~> 0.3"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<rdoc>, ["~> 3.11"])
    s.add_dependency(%q<rake>, ["~> 0.9.2.2"])
    s.add_dependency(%q<rspec>, ["~> 2.7.0"])
  end
end

