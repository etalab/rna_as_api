class RefillOneDatabase
  include Interactor::Organizer

  organize DeleteDatabase, ImportOneMonthlyStock
end
