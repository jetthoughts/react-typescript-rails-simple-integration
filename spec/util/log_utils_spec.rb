require './app/util/log_utils.rb'

module Cuker
  RSpec.describe LoggerSetup do
    context "setup for class" do
      class LogTest
        include LoggerSetup
        def initialize
          init_logger
        end
      end
      let(:obj) {LogTest.new}
      it 'should init logger well' do
        inp = obj.log
        ans = inp.class
        exp = Logging::Logger
        expect(ans).to eq exp
      end
    end
  end
end
