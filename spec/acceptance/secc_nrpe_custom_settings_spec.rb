require 'spec_helper_acceptance'

describe 'Class secc_nrpe' do
  context 'with custom settings' do
    after :all do
      run_shell('service nrpe stop', expect_failures: true)
    end

    manifest = <<-EOS
        class { 'secc_nrpe':
          server_address => '127.0.0.1',
          allowed_hosts  => ['127.0.0.1', '127.0.0.2'],
          nrpe_homedir   => '/opt/monitoring',
          command_timeout => 120,
          nrpe_must_be_root => true,
        }
    EOS

    it 'runs without errors' do
      run_shell('service nrpe stop || exit 0')
      idempotent_apply(manifest)
    end

    describe user('nrpe') do
      it { is_expected.to exist }
      it { is_expected.to have_home_directory '/opt/monitoring' }
      it { is_expected.to have_login_shell '/sbin/nologin' }
    end

    describe file('/opt/monitoring') do
      it { is_expected.to be_directory }
      it { is_expected.to be_owned_by 'nrpe' }
      it { is_expected.to be_grouped_into 'nrpe' }
      it { is_expected.to be_mode 755 }
    end

    describe file('/etc/nagios/nrpe.cfg') do
      it { is_expected.to be_file }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
      it { is_expected.to be_mode 644 }
      its(:content) { is_expected.to include 'log_facility=daemon' }
      its(:content) { is_expected.to include 'pid_file=/var/run/nrpe/nrpe.pid' }
      its(:content) { is_expected.to include 'server_address=127.0.0.1' }
      its(:content) { is_expected.to include 'allowed_hosts=127.0.0.1,127.0.0.2' }
      its(:content) { is_expected.to include 'server_port=5666' }
      its(:content) { is_expected.to include 'nrpe_user=nrpe' }
      its(:content) { is_expected.to include 'nrpe_group=nrpe' }
      its(:content) { is_expected.to include 'command_timeout=120' }
    end

    describe file('/etc/sudoers.d/nrpe') do
      it { is_expected.to exist }
      it { is_expected.to be_mode 440 }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
      its(:content) { is_expected.to include 'Defaults:nrpe !requiretty' }
      its(:content) { is_expected.to include 'nrpe ALL=(root) NOPASSWD: NRPE_WILDCARD' }
    end
  end
end
