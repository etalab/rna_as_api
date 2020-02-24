require 'rails_helper'

describe StartImportIfNeeded do
  include_context 'mute interactors'

  context 'there is not one waldec and one import' do
    subject(:context) { described_class.call(link_import: nil, link_waldec: 'not-nil') }
    it 'fails' do
      expect(context).to be_a_failure
    end
  end

  # TODO: rest of the tests
end
