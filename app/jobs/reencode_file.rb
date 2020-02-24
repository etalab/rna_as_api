class ReencodeFile < RNAAsAPIInteractor
  around do |interactor|
    context.csv_filenames = []

    context.unzipped_files.each do |unzipped_file|
      @input_file = unzipped_file
      @output_file = @input_file.gsub('.csv', "_#{secure_token}_reencoded.csv")

      stdout_info_log "Converting #{@input_file} to correct encoding..."

      if File.exist?(@output_file)
        stdout_warn_log "#{@output_file} already exists ! Skipping reencoding"
      else
        interactor.call
        stdout_success_log "File #{@input_file} converted correctly to #{@output_file} !"
      end

      context.csv_filenames << @output_file
    end
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

  def secure_token
    SecureRandom.hex(5)
  end

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
