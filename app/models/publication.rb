class Publication < ApplicationRecord
  self.table_name = "publications"
  has_many :publication_settings
end
