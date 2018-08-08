class AssociationRowJobs < RnaAsAPIInteractor
  def fill_associations
    associations = []
    begin
      lines.each do |line|
        associations << AssociationWaldecAttrsFromLine.instance.call(line) if current_import == 'waldec'
        associations << AssociationImportAttrsFromLine.instance.call(line) if current_import == 'import'
      end
    rescue StandardError => error
      stdout_error_log "Error: Could not finish the import task. Cause: #{error.class}"
      exit
    end

    associations
  end
end
