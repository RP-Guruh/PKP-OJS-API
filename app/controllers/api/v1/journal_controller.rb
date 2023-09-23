module Api
  module V1
    class JournalController < Api::V1::AuthenticatedController
      def all_journal
        all_journal = Journal.all
        result_array = results(all_journal)
        render json: result_array
      end

      def journal_id
        id = params[:id]
        all_journal = Journal.where(journal_id: id)
        result_array = results(all_journal)
        render json: result_array
      end

      private
      def find_issue_setting(journal_id, setting_name, primary_locale)
        JournalSetting.where(journal_id: journal_id, setting_name: setting_name, locale: primary_locale).where.not(setting_value: nil).first
      end

      def results(journals)
        journals.map do |data|
          {
            id: data.journal_id,
            acronym: data.path,
            fullname: find_issue_setting(data.journal_id, 'name', data.primary_locale)&.setting_value,
            locale: data.primary_locale,
            about: find_issue_setting(data.journal_id, 'about', data.primary_locale)&.setting_value
          }
        end
      end
    end
  end
end
