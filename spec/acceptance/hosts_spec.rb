# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'hosts class' do
  context 'without any parameters' do
    before(:all) do
      shell('echo "10.10.10.10 foo.example.com" >> /etc/hosts')
    end

    include_examples 'the example', 'no_hosts.pp'

    it_behaves_like 'an idempotent resource'

    describe file('/etc/hosts') do
      [
        %r{127.0.0.1\s+localhost\s+localhost4 localhost4.localdomain4 localhost.localdomain},
        %r{::1\s+localhost6\s+ip6-localhost ip6-loopback localhost6.localdomain6},
        %r{fe00::0\s+ip6-localnet},
        %r{ff00::0\s+ip6-mcastprefix},
        %r{ff02::1\s+ip6-allnodes},
        %r{ff02::2\s+ip6-allrouters},
        %r{#{fact('networking.ip')}\s+#{fact('networking.fqdn')}\s+#{fact('networking.hostname')}},
      ].each do |entry|
        its(:content) { is_expected.to match entry }
      end
      its(:content) { is_expected.not_to match %r{10.10.10.10} }
      its(:content) { is_expected.not_to match %r{foo.example.com} }
    end
  end

  context 'with purge => false' do
    before(:all) do
      shell('echo "10.10.10.10 foo.example.com" >> /etc/hosts')
    end

    include_examples 'the example', 'no_purge.pp'

    it_behaves_like 'an idempotent resource'

    describe file('/etc/hosts') do
      [
        %r{127.0.0.1\s+localhost\s+localhost4 localhost4.localdomain4 localhost.localdomain},
        %r{::1\s+localhost6\s+ip6-localhost ip6-loopback localhost6.localdomain6},
        %r{fe00::0\s+ip6-localnet},
        %r{ff00::0\s+ip6-mcastprefix},
        %r{ff02::1\s+ip6-allnodes},
        %r{ff02::2\s+ip6-allrouters},
        %r{#{fact('networking.ip')}\s+#{fact('networking.fqdn')}\s+#{fact('networking.hostname')}},
      ].each do |entry|
        its(:content) { is_expected.to match entry }
      end
      its(:content) { is_expected.to match %r{10.10.10.10} }
      its(:content) { is_expected.to match %r{foo.example.com} }
    end
  end

  context 'with manage_fqdn => false' do
    include_examples 'the example', 'no_manage_fqdn.pp'

    it_behaves_like 'an idempotent resource'

    describe file('/etc/hosts') do
      [
        %r{127.0.0.1\s+localhost\s+localhost4 localhost4.localdomain4 localhost.localdomain},
        %r{::1\s+localhost6\s+ip6-localhost ip6-loopback localhost6.localdomain6},
        %r{fe00::0\s+ip6-localnet},
        %r{ff00::0\s+ip6-mcastprefix},
        %r{ff02::1\s+ip6-allnodes},
        %r{ff02::2\s+ip6-allrouters},
      ].each do |entry|
        its(:content) { is_expected.to match entry }
      end
      its(:content) do
        is_expected.not_to match %r{#{fact('networking.ip')}\s+#{fact('networking.fqdn')}\s+#{fact('networking.hostname')}}
      end
    end
  end

  context 'with hosts param' do
    include_examples 'the example', 'hosts.pp'

    it_behaves_like 'an idempotent resource'

    describe file('/etc/hosts') do
      [
        %r{127.0.0.1\s+localhost\s+localhost4 localhost4.localdomain4 localhost.localdomain},
        %r{::1\s+localhost6\s+ip6-localhost ip6-loopback localhost6.localdomain6},
        %r{fe00::0\s+ip6-localnet},
        %r{ff00::0\s+ip6-mcastprefix},
        %r{ff02::1\s+ip6-allnodes},
        %r{ff02::2\s+ip6-allrouters},
        %r{#{fact('networking.ip')}\s+#{fact('networking.fqdn')}\s+#{fact('networking.hostname')}},
        %r{10.0.0.1\s+foo.example.com\s+foo},
        %r{10.0.0.2\s+bar.example.com\s+bar},
        %r{10.0.0.3\s+baz.example.com\s+baz},
      ].each do |entry|
        its(:content) { is_expected.to match entry }
      end
    end
  end

  context 'with default_hosts => undef' do
    before(:all) do
      # the parsedfile provider does not deal with multiple duplicate IPs, so
      # we need to remove the duplicate loop back entries
      shell('grep -vE \'127.0.0.1|::1\' /etc/hosts > /etc/hosts.new')
      # docker mounts /etc/hosts, so we can't unlink it with a mv
      shell('cat /etc/hosts.new > /etc/hosts')
    end

    include_examples 'the example', 'no_default_hosts.pp'

    it_behaves_like 'an idempotent resource'

    describe file('/etc/hosts') do
      [
        %r{127.0.0.1\s+localhost\s+localhost4 localhost4.localdomain4 localhost.localdomain},
        %r{::1\s+localhost6\s+ip6-localhost ip6-loopback localhost6.localdomain6},
        %r{fe00::0\s+ip6-localnet},
        %r{ff00::0\s+ip6-mcastprefix},
        %r{ff02::1\s+ip6-allnodes},
        %r{ff02::2\s+ip6-allrouters},
      ].each do |entry|
        its(:content) { is_expected.not_to match entry }
      end
      its(:content) do
        is_expected.to match %r{#{fact('networking.ip')}\s+#{fact('networking.fqdn')}\s+#{fact('networking.hostname')}}
      end
    end
  end
end
