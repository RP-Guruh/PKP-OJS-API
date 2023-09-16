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
    data = Journal.where(journal_id: journal_id).first
    name_journal = JournalSetting.where(journal_id: journal_id).where(locale: "en_US").where.not(setting_value: nil).where(setting_name: "name").first
    
   	result_hash = {
		  acronym: data.path,
		  id: data.journal_id,
		  locale: data.primary_locale,
		  fullname: name_journal.setting_value
		}

		# Mengkonversi hash ke format JSON
		result_json = result_hash.to_json

		# Mengirim JSON sebagai respons
		render json: result_json
	end
end
