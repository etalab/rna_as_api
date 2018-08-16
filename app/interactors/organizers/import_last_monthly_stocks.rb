class ImportLastMonthlyStocks
  include Interactor::Organizer

  organize GetLastMonthlyStockLinks, ParseLastMonthlyStockLinks, StartImportIfNeeded, SolrReindex
end
