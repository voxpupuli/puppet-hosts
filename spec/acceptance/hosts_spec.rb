# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'hosts class' do
  context 'without any parameters' do
    include_examples 'the example', 'no_hosts.pp'

    it_behaves_like 'an idempotent resource'

    describe file('/etc/hosts') do
      %w[
        127.0.0.1\s+localhost\s+localhost4 localhost4.localdomain4 localhost.localdomain
        ::1\s+localhost6\s+ip6-localhost ip6-loopback localhost6.localdomain6
        fe00::0\s+ip6-localnet
        ff00::0\s+ip6-mcastprefix
        ff02::1\s+ip6-allnodes
        ff02::2\s+ip6-allrouters
      ].each do |entry|
        its(:content) do
          is_expected.to match Regexp.new(entry)
        end
      end
    end
  end
end
