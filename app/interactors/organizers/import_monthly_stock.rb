class ImportMonthlyStock
  include Interactor::Organizer

  organize DownloadFile, UnzipFile, ImportMonthlyStockCsv, SaveLastMonthlyStockNames
end
