class InsertAssociationRowsJob < AssociationRowJobs
  attr_accessor :lines, :current_import

  def initialize(lines, current_import)
    @lines = lines
    @current_class = current_import
  end

  def perform
    associations = fill_associations

    ar_keys = %w[created_at updated_at]
    ar_keys << associations.first.keys.map(&:to_s)
    ar_keys.flatten

    ar_values_string = associations.map { |h| value_string_from_association_hash(h) }.join(', ')

    ar_query_string = " INSERT INTO associations (#{ar_keys.join(',')})
                        VALUES
                        #{ar_values_string}; "

    insert_into_database(ar_query_string)
    true
  end

  def insert_into_database(ar_query_string)
    ActiveRecord::Base.connection.execute(ar_query_string)
  rescue StandardError => error
    stdout_error_log "Error: Cannot insert association attributes. Cause : #{error.class}
      Make sure that your Solr server is launched for the right environment and accessible."
    exit
  end

  def value_string_from_association_hash(hash)
    # Used for updated_at and created_at
    # Currently both are the same since we delete the values before import, but this might change.
    now_string = Time.now.utc.to_s

    between_parenthesis = hash.values.map do |v|
      if v.nil?
        'NULL'
      else
        "'#{v.gsub("'", "''")}'"
      end
    end.join(',')

    "('#{now_string}', '#{now_string}', #{between_parenthesis})"
  end
end
