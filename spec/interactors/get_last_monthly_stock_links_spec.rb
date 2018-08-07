require 'rails_helper'

describe GetLastMonthlyStockLinks do
  subject(:context) { described_class.call }

  context 'when file server is down', vcr: { cassette_name: 'rna_server_KO', allow_playback_repeats: true } do
    it 'fails' do
      expect(context).to be_a_failure
    end
  end

  context 'when parsing the webpage', vcr: { cassette_name: 'rna_server_webpage', allow_playback_repeats: true } do
    it 'gets the redicted links' do
      expect(context.links).to eq(['https://media.interieur.gouv.fr/rna/rna_waldec_20180801.zip',
                                   'https://media.interieur.gouv.fr/rna/rna_waldec_20180801.zip'])
    end
  end
end
