namespace :rna_as_api do
  desc 'Populate database with last monthly stock'
  task import_last_monthly_stocks: :environment do
    ImportLastMonthlyStocks.call
  end

  namespace :delete_database do
    desc 'Delete database'
    task all: :environment do
      DeleteDatabase.all
    end

    desc 'Delete all waldecs associations from database'
    task waldec: :environment do
      DeleteDatabase.only_waldec
    end

    desc 'Delete all imports associations from database'
    task import: :environment do
      DeleteDatabase.only_import
    end
  end
end
