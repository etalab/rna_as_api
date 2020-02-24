require 'rails_helper'
require 'timecop'

describe ImportMonthlyStockCsv do
  include_context 'mute interactors'
  include_context 'mute progress bar'

  subject { described_class.call(current_import: import_type, csv_filenames: filenames) }

  before { Timecop.freeze(Time.utc(2018, 9, 1, 10, 5, 0)) }

  context 'waldec files' do
    let(:import_type) { 'waldec' }
    let(:filenames) { ['spec/fixtures/sample_files/rna_sample_waldec.csv'] }

    it 'persists many associations' do
      expect { subject }.to change(Association, :count).by 3
    end
  end

  context 'rna files' do
    let(:import_type) { 'import' }
    let(:filenames) { ['spec/fixtures/sample_files/rna_sample_import.csv'] }

    it 'persists many associations' do
      expect { subject }.to change(Association, :count).by 3
    end
  end
end
