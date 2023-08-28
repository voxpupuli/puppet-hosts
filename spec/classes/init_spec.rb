# frozen_string_literal: true

require 'spec_helper'

describe 'hosts' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'with no parameters' do
        it { is_expected.to compile.with_all_deps }
      end
    end
  end
end
