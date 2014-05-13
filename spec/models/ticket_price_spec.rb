require 'spec_helper'

describe TicketPrice do
  subject { build :ticket_price }

  it 'should have a valid factory' do
    expect(subject).to be_valid
  end
end
