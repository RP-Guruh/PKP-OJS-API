class PublicationSetting < ApplicationRecord
  self.table_name = "publication_settings"
  belongs_to :publications
end
