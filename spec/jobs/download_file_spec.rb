require 'rails_helper'

describe DownloadFile do
  let(:dummy_link) { 'http://www.dummy_link.com' }
  let(:dummy_download) { 'dummy_download' }

  context 'When downloading waldec file' do
    it 'succeed' do
      allow_any_instance_of(URI::HTTP).to receive(:open).and_return(dummy_download)
      expect(IO).to receive(:copy_stream).with(dummy_download, './tmp/files/dummy_name')

      described_class.call(current_import: 'waldec', link_waldec: { name: 'dummy_name', link: dummy_link })
    end
  end

  context 'When downloading import file' do
    it 'succeed' do
      allow_any_instance_of(URI::HTTP).to receive(:open).and_return(dummy_download)
      expect(IO).to receive(:copy_stream).with(dummy_download, './tmp/files/dummy_name')

      described_class.call(current_import: 'import', link_import: { name: 'dummy_name', link: dummy_link })
    end
  end
end
