require 'spec_helper_acceptance'

describe 'Class secc_nrpe' do
  context 'with custom settings' do

    let(:manifest) {
    <<-EOS
      class { 'secc_nrpe':
        server_address => '127.0.0.1',
        allowed_hosts  => ['127.0.0.1', '127.0.0.2'],
        nrpe_homedir   => '/opt/monitoring',
        command_timeout => 120,
        nrpe_must_be_root => true,
      }
    EOS
    }

    it 'should run without errors' do
      expect(apply_manifest(manifest, :catch_failures => true).exit_code).to eq(2)
    end

    it 'should re-run without changes' do
      expect(apply_manifest(manifest, :catch_changes => true).exit_code).to be_zero
    end

    describe user('nrpe') do
      it { should exist }
      it { should have_home_directory '/opt/monitoring' }
      it { should have_login_shell '/sbin/nologin' }
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
      its(:content) { is_expected.to match( /^Defaults\:nrpe \!requiretty$/ ) }
      its(:content) { is_expected.to match( /^nrpe ALL=\(root\) NOPASSWD\: NRPE_WILDCARD$/ ) }
      its(:content) { is_expected.to match( /^root ALL = \(ALL\) ALL$/ ) }
      its(:content) { is_expected.to match( /^%administrator ALL = \(ALL\) ALL$/ ) }
    end
  end
end
