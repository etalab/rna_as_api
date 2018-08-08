require 'rails_helper'

describe DownloadFile do
  context 'When downloading waldec file' do
    it 'succeed' do
      allow_any_instance_of(described_class).to receive(:open).with('dummy_link').and_return('dummy_download')
      expect(IO).to receive(:copy_stream).with('dummy_download', './tmp/files/dummy_name')

      described_class.call(current_import: 'waldec', link_waldec: { name: 'dummy_name', link: 'dummy_link' })
    end
  end

  context 'When downloading import file' do
    it 'succeed' do
      allow_any_instance_of(described_class).to receive(:open).with('dummy_link').and_return('dummy_download')
      expect(IO).to receive(:copy_stream).with('dummy_download', './tmp/files/dummy_name')

      described_class.call(current_import: 'import', link_import: { name: 'dummy_name', link: 'dummy_link' })
    end
  end
end
