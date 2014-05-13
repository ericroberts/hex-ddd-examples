require 'spec_helper'

describe Ticket do
  subject { build :ticket }

  it 'should have a valid factory' do
    expect(subject).to be_valid
  end

  context 'emails' do
    context 'with none' do
      it 'should not be valid' do
        subject.email = nil
        expect(subject).to_not be_valid
      end
    end

    context 'with invalid' do
      it 'should not be valid' do
        subject.email = 'emailblah'
        expect(subject).to_not be_valid
      end
    end

    context 'with valid' do
      it 'should be valid' do
        subject.email = 'email@email.com'
        expect(subject).to be_valid
      end
    end
  end
end
