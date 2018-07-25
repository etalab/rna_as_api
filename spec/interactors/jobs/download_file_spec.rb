# require 'rails_helper'

# describe DownloadFile do
#   patch_filename = 'rna_mock_20180701.zip'
#   patch_link = "https://fake/link/to/file/#{patch_filename}"
#   expected_downloaded_file_path = "tmp/files/#{patch_filename}"

#   subject(:context) { described_class.call(link: patch_link) }
#   context 'when downloading a file' do
#     it 'open the right file path' do
#       # binding.pry
#       expect(URI::HTTPS).to receive(:open).with(patch_link)
#     end
#   end
# end
