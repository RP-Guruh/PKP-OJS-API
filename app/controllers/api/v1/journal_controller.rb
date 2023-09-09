class Api::V1::JournalController < Api::V1::AuthenticatedController
  def getAllJournal
    data = Journal.joins(:journal_settings)
                  .group('journals.journal_id').order('journals.journal_id DESC')
                  .where("journal_settings.locale = ?", "en_US")

    render json: data.as_json(
      include: {
        journal_settings: {
          only: [:setting_name, :setting_value]
        }
      },
      only: [:journal_id, :path, :primary_locale]
    )
  end

  def getJournalByID
    journal_id = params[:id]
    data = Journal.joins(:journal_settings)
                  .group('journals.journal_id').order('journals.journal_id DESC')
                  .where("journal_settings.locale = ?", "en_US")
                  .where("journals.journal_id = ?", journal_id)

    render json: data.as_json(
      include: {
        journal_settings: {
          only: [:setting_name, :setting_value]
        }
      },
      only: [:journal_id, :path, :primary_locale]
    )
  end
end
