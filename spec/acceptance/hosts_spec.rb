# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'hosts class' do
  context 'without any parameters' do
    include_examples 'the example', 'no_hosts.pp'

    it_behaves_like 'an idempotent resource'
  end
end
