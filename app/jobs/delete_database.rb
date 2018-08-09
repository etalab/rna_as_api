class DeleteDatabase < RnaAsAPIInteractor
  def call
    DeleteDatabase.only_waldec if context.current_import == 'waldec'
    DeleteDatabase.only_import if context.current_import == 'import'
  end

  def self.all
    path_import = SaveLastMonthlyStockNames.new.path_import
    path_waldec = SaveLastMonthlyStockNames.new.path_waldec

    File.delete(path_import) if File.exist?(path_import)
    File.delete(path_waldec) if File.exist?(path_waldec)
    Association.delete_all
  end

  def self.only_waldec
    File.delete(SaveLastMonthlyStockNames.new.path_waldec) if File.exist?(SaveLastMonthlyStockNames.new.path_waldec)
    Association.where(is_waldec: true).delete_all
  end

  def self.only_import
    File.delete(SaveLastMonthlyStockNames.new.path_import) if File.exist?(SaveLastMonthlyStockNames.new.path_import)
    Association.where(is_waldec: false).delete_all
  end
end
