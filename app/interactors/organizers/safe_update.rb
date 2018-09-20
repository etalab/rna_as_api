class SafeUpdate
  include Interactor::Organizer

  organize CheckCurrentService, ImportLastMonthlyStocks
end
