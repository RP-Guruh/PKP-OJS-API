class Api::V1::JournalController < Api::V1::AuthenticatedController
  def getAllJournal
    # Mengambil semua data jurnal
    all_journals = Journal.all

    # Inisialisasi array kosong untuk menyimpan hasil
    result_array = []

    # Iterasi melalui semua jurnal
    all_journals.each do |data|
      name_journal = JournalSetting.where(journal_id: data.journal_id)
                                   .where(locale: data.primary_locale)
                                   .where.not(setting_value: nil)
                                   .where(setting_name: "name")
                                   .first
      about_journal = JournalSetting.where(journal_id: data.journal_id)
                                    .where(locale: data.primary_locale)
                                    .where.not(setting_value: nil)
                                    .where(setting_name: "about")
                                    .first

      # Buat hash hasil untuk setiap jurnal
      result_hash = {
        id: data.journal_id,
        acronym: data.path,
        fullname: name_journal&.setting_value,
        locale: data.primary_locale,
        about: about_journal&.setting_value
      }

      # Tambahkan hash hasil ke dalam array hasil
      result_array << result_hash
    end

    # Sekarang result_array berisi semua data yang diinginkan untuk semua jurnal
    render json: result_array
  end

  def getJournalByID
    journal_id = params[:id]
    data = Journal.where(journal_id: journal_id).first
    name_journal = JournalSetting.where(journal_id: journal_id).where(locale: data.primary_locale).where.not(setting_value: nil).where(setting_name: "name").first
    about_journal = JournalSetting.where(journal_id: journal_id).where(locale: data.primary_locale).where.not(setting_value: nil).where(setting_name: "about").first
    
    
   	result_hash = {
   		id: data.journal_id,
		  acronym: data.path,
		  fullname: name_journal.setting_value,
		  locale: data.primary_locale,
		  about: about_journal.setting_value
		}

		# Mengkonversi hash ke format JSON
		result_json = result_hash.to_json

		# Mengirim JSON sebagai respons
		render json: result_json
	end
end
