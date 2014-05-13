require 'spec_helper'

describe TicketCharger do
  subject { TicketCharger.new(args) }
  let(:args) {{
    tickets: [ticket],
    token: 'token'
  }}
  let(:ticket) { build :ticket }

  it 'should initialize with tickets and a token' do
    expect { subject }.to_not raise_error
  end

  describe 'validations' do
    context 'invalid' do
      let(:args) { {} }

      it 'should be invalid' do
        expect(subject).to_not be_valid
      end
    end
  end
end
