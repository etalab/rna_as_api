require 'zip'

class UnzipFile < RNAAsAPIInteractor
  DESTINATION = 'tmp/files/'.freeze

  def call
    context.unzipped_files = []
    unzip_files
  end

  private

  def unzip_files
    Zip::File.open(context.filepath) do |zip_file|
      zip_file.each do |file|
        unzipped_file_path = File.join(DESTINATION, file.name)

        if File.exist?(unzipped_file_path)
          stdout_warn_log "Skipping unzip of file #{file.name} already a file at destination #{unzipped_file_path}"
        else
          zip_file.extract(file, unzipped_file_path)
          stdout_success_log "Unzipped file #{unzipped_file_path} successfully"
        end

        context.unzipped_files << unzipped_file_path
      end
    end
  end
end
