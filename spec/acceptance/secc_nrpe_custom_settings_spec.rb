require 'spec_helper_acceptance'

describe 'Class secc_nrpe' do
  context 'with custom settings' do

    command("service nrpe stop")

    let(:manifest) {
    <<-EOS
      class { 'secc_nrpe':
        server_address => '127.0.0.1',
        allowed_hosts  => ['127.0.0.1', '127.0.0.2']
      }
    EOS
    }

    it 'should run without errors' do
      expect(apply_manifest(manifest, :catch_failures => true).exit_code).to eq(2)
    end

    it 'should re-run without changes' do
      expect(apply_manifest(manifest, :catch_changes => true).exit_code).to be_zero
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
    end
  end
end