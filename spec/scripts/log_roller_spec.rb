require 'spec_helper'
require_relative '../../scripts/lib/log_roller.rb'

describe LogRoller do

  context 'when included into an object' do

    subject do
      Foo = Class.new { include LogRoller }
      Foo.new
    end

    it 'adds an accessor named :log that holds a Logger instance' do
      expect(subject.log).to be_a Logger
    end
  end
end