require 'spec_helper'

describe Charger do
  subject { Charger.new(args) }
  let(:args) do
    {
      amount: 100.to_money,
      card: token.id
    }
  end
  let(:token) { OpenStruct.new(JSON.parse(File.read('spec/support/stripe/token.json'))) }

  it 'should initialize without error' do
    expect { subject }.to_not raise_error
  end

  context 'with required args' do
    it 'should be valid' do
      expect(subject).to be_valid
    end

    context 'with description' do

      it 'should still be valid' do
        args.merge(description: 'Description')
        expect(subject).to be_valid
      end
    end
  end

  context 'without required args' do
    after { expect(subject).to_not be_valid }

    it 'should not be valid without an amount' do
      args.delete(:amount)
    end

    it 'should not be valid without a card' do
      args.delete(:card)
    end

    it 'should not be valid without card or amount' do
      args.delete(:amount)
      args.delete(:card)
    end
  end

  describe '#purchase!' do
    before { allow(Stripe::Charge).to receive(:create) }

    it 'should tell stripe to create a charge' do
      expect(Stripe::Charge).to receive(:create)
      subject.purchase!
    end

    context 'success' do
      it 'should create a new charge object' do
        expect(subject.charge).to_not be_present
        subject.purchase!
        expect(subject.charge).to be_present
      end
    end
  end
end


