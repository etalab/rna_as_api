class ImportOneMonthlyStock
  include Interactor::Organizer

  organize DownloadFile, UnzipFile, ReencodeFile, ImportMonthlyStockCsv, SaveLastMonthlyStockNames
end
