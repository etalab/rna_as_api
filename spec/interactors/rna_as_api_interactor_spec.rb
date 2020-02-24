require 'rails_helper'

describe RNAAsAPIInteractor do
  include_context 'mute interactors'

  context 'when outputing info' do
    it 'output the right format' do
      expect { described_class.new.stdout_info_log('tEsT MesSage') }
        .to output("------>  Test message\n").to_stdout
    end

    it 'log to a log file' do
      expect_any_instance_of(Logger).to receive(:info).with('------>  Test message2')
      described_class.new.stdout_info_log('tEsT MesSage2')
    end
  end

  context 'when outputing success logs' do
    it 'output the right format' do
      expect { described_class.new.stdout_success_log('tEsT MesSage') }
        .to output("       \e[0;32;49m✓  Test message\e[0m\n").to_stdout
    end

    it 'log to a log file' do
      expect_any_instance_of(Logger).to receive(:info).with("       \e[0;32;49m✓  Test message2\e[0m")
      described_class.new.stdout_success_log('tEsT MesSage2')
    end
  end

  context 'when outputing warn logs' do
    it 'output the right format' do
      expect { described_class.new.stdout_warn_log('tEsT MesSage') }
        .to output("       \e[0;33;49m⚠ Test message\e[0m\n").to_stdout
    end

    it 'log to a log file' do
      expect_any_instance_of(Logger).to receive(:error).with("       \e[0;33;49m⚠ Test message2\e[0m")
      described_class.new.stdout_warn_log('tEsT MesSage2')
    end
  end

  context 'when outputing error logs' do
    it 'output the right format' do
      expect { described_class.new.stdout_error_log('tEsT MesSage') }
        .to output("       \e[0;31;49m✖ Test message\e[0m\n").to_stdout
    end

    it 'log to a log file' do
      expect_any_instance_of(Logger).to receive(:fatal).with("       \e[0;31;49m✖ Test message2\e[0m")
      described_class.new.stdout_error_log('tEsT MesSage2')
    end
  end
end
