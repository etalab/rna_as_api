class ReencodeFile < RnaAsAPIInteractor
  around do |interactor|
    @input_file = context.unzipped_files.first
    @output_file = @input_file.gsub('.csv', '_reencoded.csv')

    stdout_info_log "Converting #{@input_file} to correct encoding..."

    if File.exist?(@output_file)
      stdout_warn_log "#{@output_file} already exists ! Skipping reencoding"
    else
      interactor.call
      stdout_success_log "File #{@input_file} converted correctly to #{@output_file} !"
    end
    context.csv_filename = @output_file
  end

  def call
    File.open(@input_file, 'r') do |input_stream|
      File.open(@output_file, 'w') do |output_stream|
        input_stream.each_line do |line|
          output_line = encode_with_options(line)
          output_stream << output_line
        end
      end
    end
  end

  private

  def encode_with_options(line)
    line.encode(
      # To
      Encoding::UTF_8,
      # From
      Encoding::ISO_8859_1,
      invalid: :replace,
      undef: :replace,
      universal_newline: true
    )
  end
end
