require 'spec_helper'

describe Charger do
  subject { Charger.new(args) }
  let(:amount) { 100.to_money }
  let(:args) do
    {
      amount: amount,
      token: token.id
    }
  end
  let(:card) do
    {
      number: '42' * 8,
      exp_month: 12,
      exp_year: Date.today.year + 2,
      cvc: 123
    }
  end
  let(:token) do
    OpenStruct.new(
      JSON.parse(
        File.read('spec/support/stripe/token.json')
      )
    )
  end
  # Uncomment this if you want to actually test against Stripe API
  # let(:token) { Stripe::Token.create(card: card) }

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

    it 'should not be valid without a token' do
      args.delete(:token)
    end

    it 'should not be valid without token or amount' do
      args.delete(:amount)
      args.delete(:token)
    end
  end

  describe '#purchase!' do
    let(:purchase_args) do
      {
        amount: amount.cents,
        currency: amount.currency.to_s,
        card: token.id
      }
    end
    let(:result) { true }

    # Comment this out to test against Stripe API
    before { allow(Stripe::Charge).to receive(:create).and_return(result) }

    it 'should tell stripe to create a charge' do
      expect(Stripe::Charge).to receive(:create).with(purchase_args)
      subject.purchase!
    end

    context 'success' do
      let(:result) { stripe_success }

      it 'should create a new charge object' do
        expect(subject.charge).to_not be_present
        subject.purchase!
        expect(subject.charge).to be_present
      end
    end

    context 'failure' do
      let(:error) { Stripe::CardError.new('error message', '_', '_', '_') }

      before { allow(Stripe::Charge).to receive(:create).and_raise(error) }

      it 'should not raise an error' do
        expect { subject.purchase! }.to_not raise_error
      end

      it 'should set the charger error to the error' do
        subject.purchase!
        expect(subject.error).to eq error
      end
    end
  end
end
