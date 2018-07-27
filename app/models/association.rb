class Association < ApplicationRecord
  searchable do
    text :titre
  end

  def self.only_waldec
    where(is_waldec: 'true')
  end

  def self.only_import
    where(is_waldec: 'false')
  end
end
