require 'rails_helper'

describe SaveLastMonthlyStockNames do
  before(:all) do
    @test_folder = 'spec/fixtures/save_link_folder'
    @full_path_waldec = "#{@test_folder}/test_file_waldec.txt"
    @full_path_import = "#{@test_folder}/test_file_import.txt"

    @sample_waldec = {
      link: 'https://media.interieur.gouv.fr/rna/rna_waldec_20180801.zip',
      name: 'rna_waldec_20180801.zip',
      date: Date.parse('Wed, 01 Aug 2018')
    }
    @sample_import = {
      link: 'https://media.interieur.gouv.fr/rna/rna_import_20180801.zip',
      name: 'rna_import_20180801.zip',
      date: Date.parse('Wed, 01 Aug 2018')
    }

    FileUtils.remove_dir(@test_folder) if File.directory?(@test_folder)
  end

  after(:all) do
    FileUtils.remove_dir(@test_folder) if File.directory?(@test_folder)
  end

  context 'when folder doesnt exist' do
    it 'creates it' do
      allow_any_instance_of(described_class).to receive(:link_folder).and_return(@test_folder)
      described_class.call(link_waldec: @sample_waldec, link_import: @sample_import)
      expect(Dir.exist?(@test_folder)).to be true
    end
  end

  context 'when called on waldec' do
    it 'save the links to folder' do
      allow_any_instance_of(described_class).to receive(:link_folder).and_return(@test_folder)
      allow_any_instance_of(described_class).to receive(:path_waldec).and_return(@full_path_waldec)
      described_class.call(link_waldec: @sample_waldec, link_import: @sample_import, current_import: 'waldec')

      link_inside_waldec = File.read(@full_path_waldec)
      expect(link_inside_waldec).to eq('rna_waldec_20180801.zip')
    end
  end

  context 'when called on import' do
    it 'save the links to folder' do
      allow_any_instance_of(described_class).to receive(:link_folder).and_return(@test_folder)
      allow_any_instance_of(described_class).to receive(:path_import).and_return(@full_path_import)
      described_class.call(link_waldec: @sample_waldec, link_import: @sample_import, current_import: 'import')

      link_inside_import = File.read(@full_path_import)
      expect(link_inside_import).to eq('rna_import_20180801.zip')
    end
  end
end
