class Journal < ApplicationRecord
  self.table_name = "journals"
  has_many :journal_settings
end
