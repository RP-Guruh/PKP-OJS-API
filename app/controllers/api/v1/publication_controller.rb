class Api::V1::PublicationController < Api::V1::AuthenticatedController

  # mendapatkan semua terbitan publikasi dari semua jurnal
  def getAllPublication

    publication = Publication.all

    result_array = []

    publication.each do |data|
      copyrightYear = PublicationSetting.where(publication_id: data.publication_id).where(setting_name: 'copyrightYear').first
      issueId = PublicationSetting.where(publication_id: data.publication_id).where(setting_name: 'issueId').first
      pages = PublicationSetting.where(publication_id: data.publication_id).where(setting_name: 'pages').first
      licenseUrl = PublicationSetting.where(publication_id: data.publication_id).where(setting_name: 'licenseUrl').first
      doi = PublicationSetting.where(publication_id: data.publication_id).where(setting_name: ' pub-id::doi').first
      abstract = PublicationSetting.where(publication_id: data.publication_id).where(setting_name: 'abstract').first
      subtitle = PublicationSetting.where(publication_id: data.publication_id).where(setting_name: 'subtitle').first
      title = PublicationSetting.where(publication_id: data.publication_id).where(setting_name: 'title').first

      result_hash = {
        publication_id: data.publication_id,
        date_published: data.date_published,
        copyrightYear: copyrightYear&.setting_value,
        issueId: issueId&.setting_value,
        pages: pages&.setting_value,
        licenseUrl: licenseUrl&.setting_value,
        doi: doi&.setting_value,
        abstract: abstract&.setting_value,
        subtitle: subtitle&.setting_value,
        title: title&.setting_value
      }
      result_array << result_hash
    end
    render json: result_array
  end

  def getPublicationById

    publication_id = params[:id]
    result_array = []

    publication = Publication.where(publication_id: publication_id).first
    copyrightYear = PublicationSetting.where(publication_id: publication.publication_id).where(setting_name: 'copyrightYear').first
    issueId = PublicationSetting.where(publication_id: publication.publication_id).where(setting_name: 'issueId').first
    pages = PublicationSetting.where(publication_id: publication.publication_id).where(setting_name: 'pages').first
    licenseUrl = PublicationSetting.where(publication_id: publication.publication_id).where(setting_name: 'licenseUrl').first
    doi = PublicationSetting.where(publication_id: publication.publication_id).where(setting_name: ' pub-id::doi').first
    abstract = PublicationSetting.where(publication_id: publication.publication_id).where(setting_name: 'abstract').first
    subtitle = PublicationSetting.where(publication_id: publication.publication_id).where(setting_name: 'subtitle').first
    title = PublicationSetting.where(publication_id: publication.publication_id).where(setting_name: 'title').first

    result_hash = {
      publication_id: publication.publication_id,
      date_published: publication.date_published,
      copyrightYear: copyrightYear&.setting_value,
      issueId: issueId&.setting_value,
      pages: pages&.setting_value,
      licenseUrl: licenseUrl&.setting_value,
      doi: doi&.setting_value,
      abstract: abstract&.setting_value,
      subtitle: subtitle&.setting_value,
      title: title&.setting_value
    }
    result_array << result_hash
    render json: result_array

  end

  def getAllPublicationByLimit
    data = Publication.joins(:publication_settings)
                      .where.not(publications: { date_published: nil })
                      .group(:publication_id)
                      .order(publication_id: :desc)
                      .limit(params[:limit])

    render json: data.as_json(
      include: {
        publication_settings: {
          only: [:setting_name, :setting_value]
        }
      },
      only: [:publication_id, :date_published]
    )
  end

  def getAllPublicationByJournal
    data = Publication.joins(:publication_settings)
                      .where.not(publications: { date_published: nil })
                      .where("publications.section_id = ?", params[:id])
                      .group(:publication_id)
                      .order(publication_id: :desc)

    render json: data.as_json(
      include: {
        publication_settings: {
          only: [:setting_name, :setting_value]
        }
      },
      only: [:publication_id, :date_published]
    )
  end

  def getAllPublicationByIssue
    data = Publication.joins(:publication_settings)
                      .where.not(publications: { date_published: nil })
                      .where("publications.section_id = ?", params[:journal])
                      .where("publication_settings.setting_name = ?", "issueId")
                      .where("publication_settings.setting_value = ?", params[:issue])
                      .group(:publication_id)
                      .order(publication_id: :desc)

    render json: data.as_json(
      include: {
        publication_settings: {
          only: [:setting_name, :setting_value]
        }
      },
      only: [:publication_id, :date_published]
    )
  end
end
