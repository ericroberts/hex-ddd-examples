require 'spec_helper'

describe Passenger do
  subject { build :passenger }

  it 'should have a valid factory' do
    expect(subject).to be_valid
  end

  context 'invalid' do
    it 'should not be valid with missing attributes' do
      [:name, :email].each do |attribute|
        subject.send("#{attribute}=".to_sym, nil)
        expect(subject).to_not be_valid
      end
    end

    it 'should not be valid with an invalid email' do
      subject.email = 'email'
      expect(subject).to_not be_valid
    end
  end
end
