class Issue < ApplicationRecord
  self.table_name = "issues"
  has_many :issue_settings
end
