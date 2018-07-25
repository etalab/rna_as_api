class ImportLastMonthlyStocks
  include Interactor::Organizer

  organize GetLastMonthlyStockLinks, ParseLastMonthlyStockLinks, CheckLastMonthlyStockLinks,
           DeleteDatabase, ImportMonthlyStock
end
