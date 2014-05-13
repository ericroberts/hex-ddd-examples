require 'spec_helper'

describe TicketCharger do
  subject { TicketCharger.new(args) }
  let(:args) do
    {
      tickets: [ticket],
      token: 'token'
    }
  end
  let(:ticket) { build :ticket }

  it 'should initialize with tickets and a token' do
    expect { subject }.to_not raise_error
  end

  describe 'validations' do

    it 'should be valid' do
      expect(subject).to be_valid
    end

    context 'invalid' do
      let(:args) { {} }

      it 'should be invalid' do
        expect(subject).to_not be_valid
      end
    end
  end

  describe '#total' do

    context 'with one ticket' do

      it 'should be the price of one ticket' do
        subject.tickets = [ticket]
        expect(subject.total).to eq ticket.price
      end
    end

    context 'with three tickets' do

      it 'should be the price of three tickets' do
        ticket_price = build(:ticket_price, price: 500)

        subject.tickets = [
          build(:ticket, ticket_price: ticket_price),
          build(:ticket, ticket_price: ticket_price),
          build(:ticket, ticket_price: ticket_price)
        ]

        expect(subject.total).to eq 3 * 500
      end
    end
  end

  describe '#charge!' do

    context 'success' do
      let(:charger) do
        charger = double()
        allow(charger).to receive(:charge!).and_return(OpenStruct.new(id: 'chargeid'))
        charger
      end

      before { allow(subject).to receive(:charger).and_return(charger) }

      it 'should tell the charger to charge the tickets' do
        expect(subject.charger).to receive(:charge!)

        subject.charge!
      end

      it "should set each ticket's external charge id" do
        subject.charge!

        expect(subject.tickets.map(&:external_charge_id).all?).to be true
      end

      it 'should persist the external charge id' do
        subject.charge!

        subject.tickets.each do |ticket|
          dbticket = Ticket.find(ticket.id)
          expect(dbticket.external_charge_id).to be_present
        end
      end

      it 'should set the external charge id to the id returned from the charger' do
        subject.charge!

        subject.tickets.each do |ticket|
          expect(ticket.external_charge_id).to eq 'chargeid'
        end
      end
    end
  end
end
