class DeleteDatabase < RNAAsAPIInteractor
  def call
    DeleteDatabase.only_waldec if context.current_import == 'waldec'
    DeleteDatabase.only_import if context.current_import == 'import'
  end

  def self.all
    stdout_info_log 'Database waldec and import will be deleted'
    path_import = SaveLastMonthlyStockNames.new.path_import
    path_waldec = SaveLastMonthlyStockNames.new.path_waldec

    File.delete(path_import) if File.exist?(path_import)
    File.delete(path_waldec) if File.exist?(path_waldec)
    Association.delete_all
    stdout_success_log 'Database waldec and import successfully deleted'
  end

  def self.only_waldec
    stdout_info_log 'Database waldec will be deleted'
    File.delete(SaveLastMonthlyStockNames.new.path_waldec) if File.exist?(SaveLastMonthlyStockNames.new.path_waldec)
    Association.where(is_waldec: true).delete_all
    stdout_success_log 'Database waldec successfully deleted'
  end

  def self.only_import
    stdout_info_log 'Database import will be deleted'
    File.delete(SaveLastMonthlyStockNames.new.path_import) if File.exist?(SaveLastMonthlyStockNames.new.path_import)
    Association.where(is_waldec: false).delete_all
    stdout_success_log 'Database import successfully deleted'
  end
end
