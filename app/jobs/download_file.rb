require 'open-uri'

class DownloadFile < RnaAsAPIInteractor
  around do |interactor|
    stdout_info_log "Attempting to download #{context.current_import}"

    filename = link_to_import[:name]
    context.filepath = "./tmp/files/#{filename}"

    if File.exist?(context.filepath)
      stdout_warn_log "#{filename} already exists ! Skipping download"
    else
      interactor.call
      stdout_success_log "Downloaded #{filename} successfuly"
    end
  end

  def call
    # Security risk : replace value
    download = open(link_to_import[:link])
    IO.copy_stream(download, context.filepath)
  end

  private

  def link_to_import
    context.current_import == 'waldec' ? context.link_waldec : context.link_import
  end
end
