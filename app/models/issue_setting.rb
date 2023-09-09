class IssueSetting < ApplicationRecord
  self.table_name = "issue_settings"
  belongs_to :issue
end
