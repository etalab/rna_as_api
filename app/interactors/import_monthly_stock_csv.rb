class ImportMonthlyStockCsv < RnaAsAPIInteractor
  around do |interactor|
    context.csv_filename = context.unzipped_files.first
    stdout_info_log "Starting csv import of #{context.csv_filename}"

    compute_row_number

    stdout_info_log 'Importing rows...'

    # quietly do
    #   stdout_association_count_change do
        # stdout_benchmark_stats do
          interactor.call
        # end
      # end
    # end
  end

  def call
    progress_bar = create_progressbar(context)
    process_csv_job(context, progress_bar)
  end

  private

  def create_progressbar(context)
    ProgressBar.create(
      total: context.number_of_rows,
      format: 'Progress %c/%C (%P %%) |%b>%i| %a %e'
    )
  end

  def process_csv_job(context, progress_bar)
    SmarterCSV.process(context.csv_filename, csv_options) do |chunk|
      InsertAssociationRowsJob.new(chunk, context.current_import).perform
      chunk.size.times { progress_bar.increment }
    end
  end

  def csv_options
    {
      chunk_size: 2_000,
      col_sep: ';',
      row_sep: :auto,
      convert_values_to_numeric: false,
      key_mapping: {},
      file_encoding: 'ASCII-8BIT'
    }
  end

  def compute_row_number
    stdout_info_log 'Computing number of rows...'
    context.number_of_rows = `wc -l #{context.csv_filename}`.split.first.to_i - 1
    stdout_success_log "Found #{context.number_of_rows} rows to import"
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

  def stdout_association_count_change
    etablissement_count_before = current_imported_class.count
    yield
    etablissement_count_after = current_imported_class.count

    entries_added = etablissement_count_after - etablissement_count_before

    puts "#{entries_added} etablissements added"
  end

  # def stdout_benchmark_stats
  #   Benchmark.bm(7) do |x|
  #     x.report(:csv_pro) do
  #       yield
  #     end
  #   end
  # end

  def current_imported_class
    context.current_import == 'waldec' ? Association.only_waldec : Association.only_import
  end
end
