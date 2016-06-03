require 'spec_helper'
    
    cmd = "grep server_address /etc/nagios/nrpe.cfg | cut -c16-31"
    ipaddress = `#{cmd}`

	describe user('nrpe') do
  		it { should exist }
  		it { should have_home_directory '/home/nrpe' }
  		it { should have_login_shell '/sbin/nologin' }
	end
	
	describe user('nagios') do
  		it { should exist }
  		it { should have_home_directory '/var/spool/nagios' }
  		it { should have_login_shell '/sbin/nologin' }
	end

	describe package ('nrpe') do
		it { should be_installed }
	end
	
	describe package ('sudo') do
		it { should be_installed }
	end
	
	describe service ('nrpe') do
		it { should be_enabled }
		it { should be_running }
	end
	
	describe command("/usr/lib64/nagios/plugins/check_nrpe -H #{ipaddress}") do
			its(:stdout) { should match /^NRPE v2.15$/ }
	end
	
	describe file('/home/nrpe/') do
		it { should exist }
		it { should be_directory }
		it { should be_mode 755 }
		it { should be_owned_by 'nrpe' }
		it { should be_grouped_into 'nrpe'}
	end
	
	describe file('/etc/nagios/') do
		it { should exist }
		it { should be_directory }
		it { should be_mode 755 }
		it { should be_owned_by 'root' }
		it { should be_grouped_into 'root'}		
	end
	
	describe file('/var/run/nrpe') do
		it { should exist }
		it { should be_directory }
		it { should be_mode 755 }
		it { should be_owned_by 'nrpe' }
		it { should be_grouped_into 'nrpe'}		
	end
	
	describe file('/etc/sudoers.d/nrpe') do
		it { should exist }
		it { should be_mode 440 }
		it { should be_owned_by 'root' }
		it { should be_grouped_into 'root' }
		its(:content) { should match /^Defaults\:nrpe \!requiretty$/ }
	end
	
	describe file('/etc/nagios/nrpe.cfg') do
		it { should exist }
		it { should be_mode 644 }
		it { should be_owned_by 'root' }
		it { should be_grouped_into 'root' }
		its(:content) { should match /^log\_facility\=daemon$/}
		its(:content) { should match /^pid\_file\=\/var\/run\/nrpe\/nrpe.pid$/}
		its(:content) { should match /^server\_address\=(\d\d\d|\d\d|\d).(\d\d\d|\d\d|\d).(\d\d\d|\d\d|\d).(\d\d\d|\d\d|\d)$/ }
		its(:content) { should match /^server\_port\=5666$/ }
		its(:content) { should match /^nrpe\_user\=nrpe$/ }
		its(:content) { should match /^nrpe\_group\=nrpe$/ }
		its(:content) { should match /^dont\_blame\_nrpe\=\d$/ }
		its(:content) { should match /^debug\=\d$/ }
		its(:content) { should match /^command\_timeout\=\d\d$/ }
		its(:content) { should match /^connection\_timeout\=\d\d\d$/ }
		its(:content) { should match /^include\_dir\=\/etc\/nrpe.d\/$/ }
	end