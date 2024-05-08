require 'spec_helper'
describe 'nfsserver' do
  let :facts do
    {
      osfamily: 'OpenBSD',
      os: { family: 'OpenBSD' },
    }
  end

  context 'with default parameters' do
    exports_content = File.read('spec/fixtures/nfsserver_exports.empty')

    it { is_expected.to compile.with_all_deps }  # same as above except it will test all the dependencies
    it { is_expected.to contain_class('nfsserver::config') }
    it { is_expected.to contain_class('nfsserver::service') }
    it {
      is_expected.to contain_file('/etc/exports').with(
        owner: 'root',
        group: '0',
        mode: '0640',
      ).with_content(exports_content)
    }
    it { is_expected.to contain_service('portmap') }
    it {
      is_expected.to contain_service('nfsd').with(
        ensure: 'running',
        enable: 'true',
        flags: '-tun 4',
      )
    }
    it {
      is_expected.to contain_service('lockd').with(
        ensure: 'running',
        enable: 'true',
        flags: '',
      )
    }
    it {
      is_expected.to contain_service('statd').with(
        ensure: 'running',
        enable: 'true',
        flags: '',
      )
    }
    it {
      is_expected.to contain_service('mountd').with(
        ensure: 'running',
        enable: 'true',
        flags: '',
      )
    }
  end

  context 'with custom parameters' do
    exports_content = File.read('spec/fixtures/nfsserver_exports.multiline')
    let(:params) do
      {
        exports: {
          export_node1: {
            directory: {
              '/export/node1': {
                owner: 'root',
                group: '0',
                mode: '0755',
              },
            },
            exportparams: '-ro -maproot=root:wheel',
            clients: 'node1.example.com 192.168.0.1'
          },
          export_node2: {
            directory: '/export/node2',
            exportparams: '-ro -mapall=nobody',
            clients: '-network=10.0.0 -mask=255.255.255.0',
          },
        },
        enable_lockd: false,
        enable_statd: false,
        nfsd_flags: '-tun 5',
        mountd_flags: 'yuck',
        statd_flags: 'bula',
        lockd_flags: 'foo',
        service_ensure: 'stopped',
        service_enable: false,
      }
    end

    it { is_expected.to compile.with_all_deps }  # same as above except it will test all the dependencies
    it { is_expected.to contain_class('nfsserver::config') }
    it { is_expected.to contain_class('nfsserver::service') }
    it {
      is_expected.to contain_file('/etc/exports').with(
        owner: 'root',
        group: '0',
        mode: '0640',
      ).with_content(exports_content)
    }
    it {
      is_expected.to contain_file('/export/node1').with(
        ensure: 'directory',
        owner: 'root',
        group: '0',
        mode: '0755',
      )
    }
    it { is_expected.not_to contain_file('/export/node2') }
    it { is_expected.not_to contain_service('lockd') }
    it { is_expected.not_to contain_service('statd') }
    it {
      is_expected.to contain_service('nfsd').with(
        ensure: 'stopped',
        enable: 'false',
        flags: '-tun 5',
      )
    }
    it {
      is_expected.to contain_service('mountd').with(
        ensure: 'stopped',
        enable: 'false',
        flags: 'yuck',
      )
    }
  end
end
