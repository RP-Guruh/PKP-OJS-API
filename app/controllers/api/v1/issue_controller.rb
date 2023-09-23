# frozen_string_literal: true
module Api
  module V1
    # Controller for managing journals in the API v1.
    class IssueController < Api::V1::AuthenticatedController
      def all_issue
        # get all issue
        all_issue = Issue.all
        result_array = results(all_issue)
        render json: result_array
      end

      # @return [nil]
      def issue_journal
        # Get all issues by journal id
        journal_id = params[:id]
        all_issue = Issue.where(journal_id: journal_id)
        result_array = results(all_issue)
        render json: result_array
      end

      def issue_id
        issue_id = params[:id]
        all_issue = Issue.where(issue_id: issue_id)
        result_array = results(all_issue)
        render json: result_array
      end

      private

      def find_issue_setting(issue_id, setting_name)
        IssueSetting.where(issue_id: issue_id, setting_name: setting_name).first
      end

      def results(issues)
        issues.map do |data|
          {
            issue_id: data.issue_id,
            journal_id: data.journal_id,
            volume: data.volume,
            number: data.number,
            year: data.year,
            doi: find_issue_setting(data.issue_id, 'pub-id::doi')&.setting_value,
            cover: find_issue_setting(data.issue_id, 'coverImage')&.setting_value,
            desc: find_issue_setting(data.issue_id, 'description')&.setting_value,
            title: find_issue_setting(data.issue_id, 'title')&.setting_value
          }
        end
      end
    end
  end
end
