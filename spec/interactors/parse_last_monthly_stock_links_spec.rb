require 'rails_helper'

describe ParseLastMonthlyStockLinks do
  include_context 'mute interactors'

  context 'when parsing the links' do
    subject(:context) do
      described_class.call(links: ['https://media.interieur.gouv.fr/rna/rna_waldec_20180801.zip',
                                   'https://media.interieur.gouv.fr/rna/rna_import_20180801.zip'])
    end
    it 'succeeds' do
      expected_waldec = {
        link: 'https://media.interieur.gouv.fr/rna/rna_waldec_20180801.zip',
        name: 'rna_waldec_20180801.zip',
        date: Date.parse('Wed, 01 Aug 2018')
      }
      expected_import = {
        link: 'https://media.interieur.gouv.fr/rna/rna_import_20180801.zip',
        name: 'rna_import_20180801.zip',
        date: Date.parse('Wed, 01 Aug 2018')
      }
      expect(context.link_waldec).to eq(expected_waldec)
      expect(context.link_import).to eq(expected_import)
    end
  end

  context 'when both links are waldec' do
    subject(:context) do
      described_class.call(links: ['https://media.interieur.gouv.fr/rna/rna_waldec_20180801.zip',
                                   'https://media.interieur.gouv.fr/rna/rna_waldec_20180801.zip'])
    end
    it 'fails' do
      expect(context).to be_a_failure
    end
  end
end
