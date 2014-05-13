require 'spec_helper'

describe Trip do
  subject { build :trip }

  it 'should have a valid factory' do
    expect(subject).to be_valid
  end
end
