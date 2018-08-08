require 'rails_helper'

describe ReencodeFile do
  context 'When reencoding a file' do
    path_to_test_csv = 'spec/fixtures/sample_files/reencode_test.csv'
    expected_reencoded_path = 'spec/fixtures/sample_files/reencode_test_reencoded.csv'

    before(:all) do
      File.delete(expected_reencoded_path) if File.exist?(expected_reencoded_path)
    end

    after(:all) do
      File.delete(expected_reencoded_path)
    end

    it 'succeed' do
      described_class.call(unzipped_files: [path_to_test_csv])
      expect(File.read(expected_reencoded_path).encoding.name).to eq('UTF-8')
    end
  end
end
