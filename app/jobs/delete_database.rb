class DeleteDatabase < RnaAsAPIInteractor
  def call
    DeleteDatabase.only_waldec if context.current_import == 'waldec'
    DeleteDatabase.only_import if context.current_import == 'import'
  end

  def self.all
    Association.delete_all
  end

  def self.only_waldec
    Association.where(is_waldec: true).delete_all
  end

  def self.only_import
    Association.where(is_waldec: false).delete_all
  end
end
