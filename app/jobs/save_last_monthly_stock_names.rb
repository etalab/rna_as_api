class SaveLastMonthlyStockNames < RnaAsAPIInteractor
  around do
    unless File.directory?(link_folder)
      FileUtils.mkdir(link_folder)
      stdout_warn_log("Warning : Folder #{link_folder} doesn't exist.
      It will be created for the import to continue.")
    end

    File.open(path_waldec, 'w+') { |f| f << context.link_waldec['name'] } if context.current_import == 'waldec'
    File.open(path_import, 'w+') { |f| f << context.link_import['name'] } if context.current_import == 'import'

    stdout_success_log 'Import done !'
  end

  def link_folder
    '.last_monthly_stocks_applied'
  end

  def path_waldec
    "#{link_folder}/last_waldec_file_applied.txt"
  end

  def path_import
    "#{link_folder}/last_import_file_applied.txt"
  end
end
