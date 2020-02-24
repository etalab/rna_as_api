class DeleteTemporaryFiles < RNAAsAPIInteractor
  include Interactor

  def call
    return unless context.success?

    stdout_info_log("Deleting files in #{temp_files_location}")

    Dir["#{temp_files_location}/*"].select { |f| looks_like_temporary_file(f) }.each do |file|
      File.delete(file)
      stdout_success_log("Deleted #{file}")
    end
  end

  def temp_files_location
    'tmp/files'
  end

  def looks_like_temporary_file(file)
    looks_like_import_files(file) || looks_like_waldec_file(file)
  end

  def looks_like_import_files(file)
    File.basename(file).match(/^rna_import_/)
  end

  def looks_like_waldec_file(file)
    File.basename(file).match(/^rna_waldec_/)
  end
end
