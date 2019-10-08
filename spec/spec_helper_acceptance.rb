require 'beaker'

# monkeypatch ...
if (ENV["BEAKER_set"] =~ /centos8/)
  module Beaker
    module HostPrebuiltSteps
      UNIX_PACKAGES = ['curl', 'chrony']
    end
  end
end

require 'beaker-pe'
require 'beaker-puppet'
require 'beaker-rspec'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'
require 'pry'
require 'puppet'

configure_type_defaults_on(hosts)

RSpec.configure do |c|
  module_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.formatter = :documentation

  c.expect_with :rspec do |c2|
    c2.syntax = :expect
  end

  c.before :all do
    hosts.each do |host|
      on(host, "service nrpe stop || exit 0")
    end
  end

  c.before :suite do
    # Install module to all hosts
    hosts.each do |host|
      install_puppet_on(host)

      install_dev_puppet_module_on(host, :source => module_root, :module_name => 'secc_nrpe')
      # Install dependencies
      on(host, puppet('module', 'install', 'puppetlabs-stdlib'))
      # Add more setup code as needed
    end
  end
end
