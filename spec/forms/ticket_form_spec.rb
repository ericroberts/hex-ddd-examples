require 'spec_helper'

describe TicketForm do
  subject { TicketForm.new(request) }

  let(:request) {{
    trip: trip,
    price: ticket_price,
    passengers: [passenger]
  }}
  let(:passenger)     { build :passenger }
  let(:trip)          { build :trip }
  let(:ticket_price)  { build :ticket_price, trip: trip, price: 500 }

  context 'validations' do
    it 'should be valid' do
      expect(subject).to be_valid
    end

    it 'should validate passengers' do
      subject.passengers.each do |passenger|
        expect(passenger).to receive(:valid?)
      end

      subject.valid?
    end

    context 'invalid' do
      context 'attributes' do
        [:passengers, :price, :trip].each do |attribute|
          it "should not be valid if there is no #{attribute}" do
            subject.send("#{attribute}=".to_sym, nil)
            expect(subject).to_not be_valid
          end
        end
      end

      context 'request' do
        [:passengers, :price, :trip].each do |attribute|
          it "should not be valid if there is no #{attribute}" do
            request[attribute] = nil
            expect(subject).to_not be_valid
          end
        end
      end
    end
  end

  context 'valid request' do

    it 'should have an array of passengers' do
      expect(subject.passengers).to eq [passenger]
    end

    it 'should have a trip' do
      expect(subject.trip).to be trip
    end

    it 'should have a price' do
      expect(subject.price).to be ticket_price
    end
  end

  context 'defaults' do
    subject { TicketForm.new }

    it 'should always have at least one passenger' do
      expect(subject.passengers).to be_present
    end
  end

  context 'coercion' do
    it 'should turn an array of hashes into passengers' do
      request[:passengers] = [{ name: 'Passenger', email: 'passenger@trips.com' }]
      is_everyone_a_passenger = subject.passengers.all? { |p| p.is_a? Passenger }
      expect(is_everyone_a_passenger).to be true
    end
  end
end
