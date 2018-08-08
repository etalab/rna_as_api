require 'rails_helper'
require 'timecop'

describe ImportMonthlyStockCsv do
  before(:all) do
    Timecop.freeze(Time.utc(2018, 9, 1, 10, 5, 0))
  end

  after(:all) do
    Timecop.return
  end

  context 'when importing waldec file' do
    it 'succeed' do
      expected_query_string = File.read('spec/fixtures/sample_files/query_string_rna_sample_waldec.txt')
      sample_file = 'spec/fixtures/sample_files/rna_sample_waldec.csv'

      expect(ActiveRecord::Base).to receive_message_chain(:connection, :execute).with(expected_query_string)
      described_class.call(current_import: 'waldec', csv_filename: sample_file)
    end
  end
  context 'when importing import file' do
    it 'succeed' do
      expected_query_string = File.read('spec/fixtures/sample_files/query_string_rna_sample_import.txt')
      sample_file = 'spec/fixtures/sample_files/rna_sample_import.csv'

      expect(ActiveRecord::Base).to receive_message_chain(:connection, :execute).with(expected_query_string)
      described_class.call(current_import: 'import', csv_filename: sample_file)
    end
  end
end
