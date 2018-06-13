# frozen_string_literal: true

require 'spec_helper'

describe Logux::Action do
  let(:action) { described_class.new(params: params, meta: meta) }
  let(:params) { create(:logux_params_subscribe) }
  let(:user) { User.find_or_create_by(id: 1, name: 'test') }
  let(:meta) { {} }

  describe '#subscribe' do
    subject { action.subscribe }

    context 'when ActiveRecord defined' do
      it 'tries to find record by chanel data' do
        expect(subject).to eq(user)
      end
    end
  end

  describe '#respond' do
    subject { action.respond(:processed) }

    it 'returns logux response' do
      expect(subject.status).to eq(:processed)
      expect(subject.params).to eq(params)
      expect(subject.meta).to eq({})
      expect(subject.custom_data).to be_nil
    end
  end
end
