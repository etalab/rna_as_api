class ImportLastMonthlyStocks
  include Interactor::Organizer

  organize GetLastMonthlyStockLinks, ParseLastMonthlyStockLinks, StartImportIfNeeded
end
