require 'spec_helper_acceptance'

describe 'Class secc_nrpe' do
  context 'with default nrpe config' do
    before :all do
      run_shell('service nrpe stop', expect_failures: true)
    end

    manifest = <<-EOS
        class { 'secc_nrpe': }
    EOS

    it 'runs without errors' do
      idempotent_apply(manifest)
    end

    describe package('nrpe') do
      it { is_expected.to be_installed }
    end

    describe service('nrpe') do
      if os[:family] == 'redhat' && os[:release].to_i >= 7
        it { is_expected.to be_enabled.under('systemd') }
        it { is_expected.to be_running.under('systemd') }
      else
        it { is_expected.to be_enabled }
        it { is_expected.to be_running }
      end
    end

    describe user('nrpe') do
      it { is_expected.to exist }
      it { is_expected.to have_home_directory '/home/nrpe' }
      it { is_expected.to have_login_shell '/sbin/nologin' }
    end

    describe user('nagios') do
      it { is_expected.to exist }
      it { is_expected.to have_home_directory '/var/spool/nagios' }
      it { is_expected.to have_login_shell '/sbin/nologin' }
    end

    # describe command("/usr/lib64/nagios/plugins/check_nrpe -H #{server_address}") do
    #     its(:stdout) { is_expected.to match( /^NRPE v2.15$/ ) }
    # end

    describe file('/etc/nagios/') do
      it { is_expected.to be_directory }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
      it { is_expected.to be_mode 755 }
    end

    describe file('/etc/nagios/nrpe.cfg') do
      it { is_expected.to be_file }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
      it { is_expected.to be_mode 644 }
      its(:content) { is_expected.to include 'log_facility=daemon' }
      its(:content) { is_expected.to include 'pid_file=/var/run/nrpe/nrpe.pid' }
      its(:content) { is_expected.to include 'server_port=5666' }
      its(:content) { is_expected.to include 'nrpe_user=nrpe' }
      its(:content) { is_expected.to include 'nrpe_group=nrpe' }
      its(:content) { is_expected.to include 'command_timeout=60' }
      its(:content) { is_expected.to include 'allowed_hosts=127.0.0.1,172.29.70.2' }
    end

    describe file('/home/nrpe/') do
      it { is_expected.to be_directory }
      it { is_expected.to be_owned_by 'nrpe' }
      it { is_expected.to be_grouped_into 'nrpe' }
      it { is_expected.to be_mode 755 }
    end

    describe file('/var/run/nrpe') do
      it { is_expected.to be_directory }
      it { is_expected.to be_mode 755 }
      it { is_expected.to be_owned_by 'nrpe' }
      it { is_expected.to be_grouped_into 'nrpe' }
    end

    describe file('/etc/sudoers.d/nrpe') do
      it { is_expected.to exist }
      it { is_expected.to be_mode 440 }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
      its(:content) { is_expected.to include 'Defaults:nrpe !requiretty' }
    end
  end
end
