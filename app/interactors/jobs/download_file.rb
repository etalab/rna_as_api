require 'open-uri'

class DownloadFile < RnaAsAPIInteractor
  around do |interactor|
    stdout_info_log "Attempting to download #{filename}"

    context.filepath = "./tmp/files/#{filename}"
    context.filename = filename

    if File.exist?(context.filepath)
      stdout_warn_log "#{filename} already exists ! Skipping download"
    else
      interactor.call
      stdout_success_log "Downloaded #{filename} successfuly"
    end

    puts
  end

  def call
    uri = URI(context.link)
    binding.pry
    download = open(uri)
    IO.copy_stream(download, context.filepath)
  end

  private

  def filename
    URI(context.link).path.split('/').last
  end
end
