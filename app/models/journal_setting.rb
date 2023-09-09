class JournalSetting < ApplicationRecord
  self.table_name = "journal_settings"
  belongs_to :journal
end
