namespace :rna_as_api do
  desc 'Populate database with last monthly stock'
  task import_last_monthly_stock: :environment do
    ImportLastMonthlyStock.call
  end
end
