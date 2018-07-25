require 'date'

# Check if our stock links are legit and should be applied
class CheckLastMonthlyStockLinks < RnaAsAPIInteractor
  around do |interactor|
    stdout_info_log 'Checking which monthly stock to apply...'

    interactor.call
  end

  def call
    check_if_one_waldec_and_one_import
    check_date_links
    import_file_waldec_if_needed
    import_file_import_if_needed
    nothing_to_import if context.current_import.nil?
  end

  private

  def import_file_waldec_if_needed
    if context.link_waldec['apply']
      stdout_success_log('New waldec file will be imported')
      context.current_import = 'waldec'
    else
      stdout_success_log('Waldec up-to-date, no import needed.')
    end
  end

  def import_file_import_if_needed
    if context.link_import['apply'] == true
      stdout_success_log('New import file will be imported')
      context.current_import = 'import'
    else
      stdout_success_log('Import up-to-date, no import needed')
    end
  end

  def nothing_to_import
    stdout_success_log 'All up-to-date, No new imports needed.'
    exit
  end

  def check_if_one_waldec_and_one_import
    if context.link_import.nil? || context.link_waldec.nil? # rubocop:disable GuardClause
      stdout_error_log 'Error: one of the links seems to be missing.'
      context.fail!
    end
  end

  def check_date_links
    context.link_waldec['apply'] = true if should_apply_waldec?
    context.link_import['apply'] = true if should_apply_import?
  end

  def should_apply_waldec?
    saved_last_waldec_date.nil? || saved_last_waldec_date < context.link_waldec['date']
  end

  def should_apply_import?
    saved_last_import_date.nil? || saved_last_import_date < context.link_import['date']
  end

  def saved_last_import_date
    path_to_save_file = SaveLastMonthlyStockNames.new.path_import
    return Date.new unless File.exist?(path_to_save_file)

    ## TODO not finished here !!!
    File.read(SaveLastMonthlyStockNames.new.path_import)
  end

  def saved_last_waldec_date
    path_to_save_file = SaveLastMonthlyStockNames.new.path_waldec
    return Date.new unless File.exist?(path_to_save_file)
    File.read(SaveLastMonthlyStockNames.new.path_waldec)
  end
end
