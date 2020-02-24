require 'rails_helper'

# We delete temporary files only if they start with 'geo-sirene' AND finish with .csv or .csv.gz
describe DeleteTemporaryFiles do
  include_context 'mute interactors'

  let(:temp_folder) { 'spec/fixtures/sample_files/tmp_files' }
  let(:temp_files) { Dir["#{temp_folder}/*"] }

  before do
    allow_any_instance_of(described_class).to receive(:temp_files_location).and_return temp_folder

    (1..5).each do
      FileUtils.touch "#{temp_folder}/rna_import_#{SecureRandom.hex(5)}_test.txt"
      FileUtils.touch "#{temp_folder}/rna_waldec_#{SecureRandom.hex(5)}_test.txt"
    end
  end

  it 'does not delete everything' do
    described_class.call
    expect(temp_files).to include %r{file_not_to_delete}
  end

  it 'deletes rna_import files' do
    described_class.call
    expect(temp_files).not_to include %r{rna_import}
  end

  it 'deletes rna_import files' do
    described_class.call
    expect(temp_files).not_to include %r{rna_waldec}
  end
end
