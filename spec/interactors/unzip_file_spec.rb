require 'rails_helper'

describe UnzipFile do
  patch_filepath = 'spec/fixtures/sample_files/sample.zip'
  patch_filename = 'sample.csv'
  expected_unzipped_file_path = "tmp/files/#{patch_filename}"

  subject(:context) { UnzipFile.call(filepath: patch_filepath, filename: patch_filename) }

  context 'when called & The file is already there' do
    before do
      File.new(expected_unzipped_file_path, 'w')
    end

    it 'pass the adress in context' do
      expect(context.unzipped_files).to eq(["tmp/files/#{patch_filename}"])
    end
    it 'doesnt write to a new file' do
      expect_any_instance_of(Zip::File).not_to receive(:extract)
      UnzipFile.call(filepath: patch_filepath, filename: patch_filename)
    end
  end

  context 'when called & The file is not already there' do
    before do
      File.delete(expected_unzipped_file_path) if File.exist?(expected_unzipped_file_path)
    end

    it 'pass the adress in context' do
      expect(context.unzipped_files).to eq([expected_unzipped_file_path])
    end
    it 'unzip the file' do
      expect_any_instance_of(Zip::File).to receive(:extract)
      UnzipFile.call(filepath: patch_filepath, filename: patch_filename)
    end
  end
end
