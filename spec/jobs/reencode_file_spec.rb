require 'rails_helper'

describe ReencodeFile do
  include_context 'mute interactors'

  context 'When reencoding a file' do
    subject { described_class.call(unzipped_files: [path_to_test_csv, path_to_test_csv]) }

    let(:path_to_test_csv) { 'spec/fixtures/sample_files/reencode_test.csv' }
    let(:expected_reencoded_path_regex) { 'spec/fixtures/sample_files/reencode_test_*_reencoded.csv' }
    let(:files_on_disk) { Dir[expected_reencoded_path_regex] }

    after do
      FileUtils.rm_rf(files_on_disk)
    end

    it 'generates 2 reencoded files on disk' do
      subject
      expect(files_on_disk.count).to eq 2
    end

    it 'generated files are correcly encoded' do
      files_on_disk.each do |filename|
        expect(File.read(filename).encoding.name).to eq('UTF-8')
      end
    end

    it 'reencoded files are set in ouput' do
      expect(subject.csv_filenames).to match_array files_on_disk
    end
  end
end
