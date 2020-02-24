class ImportMonthlyStockCsv < RNAAsAPIInteractor
  around do |interactor|
    context.csv_filenames.each do |csv_filename|
      @csv_filename = csv_filename
      stdout_info_log "Starting csv import of #{@csv_filename}"

      compute_row_number

      stdout_info_log 'Importing rows...'

      quietly do
        interactor.call
      end
    end
  end

  def call
    progress_bar = create_progressbar(context)
    process_csv_job(context, progress_bar)
  end

  private

  def create_progressbar(_context)
    ProgressBar.create(
      total: @number_of_rows,
      format: 'Progress %c/%C (%P %%) |%b>%i| %a %e'
    )
  end

  def process_csv_job(context, progress_bar)
    SmarterCSV.process(@csv_filename, csv_options) do |chunk|
      InsertAssociationRowsJob.new(chunk, context.current_import).perform
      chunk.size.times { progress_bar.increment }
    end
  end

  def csv_options
    {
      chunk_size: 1000,
      col_sep: ';',
      row_sep: :auto,
      convert_values_to_numeric: false,
      key_mapping: {},
      file_encoding: 'UTF-8'
    }
  end

  def compute_row_number
    stdout_info_log 'Computing number of rows...'
    @number_of_rows = `wc -l #{@csv_filename}`.split.first.to_i - 1
    stdout_success_log "Found #{@number_of_rows} rows to import"
  end

  def quietly
    ar_log_level_before_block_execution = ActiveRecord::Base.logger.level
    log_level_before_block_execution = Rails.logger.level

    Rails.logger.level = :fatal
    ActiveRecord::Base.logger.level = :error
    yield
    Rails.logger.level = log_level_before_block_execution
    ActiveRecord::Base.logger.level = ar_log_level_before_block_execution
  end

  def current_imported_class
    context.current_import == 'waldec' ? Association.only_waldec : Association.only_import
  end
end
