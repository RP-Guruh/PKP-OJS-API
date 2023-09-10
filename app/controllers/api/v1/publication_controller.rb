class Api::V1::PublicationController < Api::V1::AuthenticatedController

  # mendapatkan semua terbitan publikasi dari semua jurnal
  def getAllPublication
    data = Publication.joins(:publication_settings)
                      .where.not(publications: { date_published: nil })
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

  def getPublicationById
    data = Publication.joins(:publication_settings)
                      .where.not(publications: { date_published: nil })
                      .where("publications.publication_id = ?", params[:id])
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
