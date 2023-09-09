class Api::V1::IssueController < ApplicationController

  # Mendapatkan semua issue dari semua journal
  def getAllIssue
    data = Issue.joins(:issue_settings).group('issues.issue_id').order('issues.date_published DESC')

    render json: data.as_json(
      include: {
        issue_settings: {
          only: [:setting_name, :setting_value]
        }
      },
      only: [:issue_id, :journal_id, :volume, :number, :year, :date_published]
    )
  end

  # Mendapatkan semua issue berdasarkan id jurnal
  def getAllIssueByJournal
    journal_id = params[:id]
    data = Issue.joins(:issue_settings)
                .group('issues.issue_id')
                .order('issues.date_published DESC')
                .where("issues.journal_id = ?", journal_id)

    render json: data.as_json(
      include: {
        issue_settings: {
          only: [:setting_name, :setting_value]
        }
      },
      only: [:issue_id, :journal_id, :volume, :number, :year, :date_published]
    )
  end

  # Mendaptkan issue berdasarkan id issue nya
  def getIssueByID
    issue_id = params[:id]
    data = Issue.joins(:issue_settings)
                .group('issues.issue_id')
                .order('issues.date_published DESC')
                .where("issues.issue_id = ?", issue_id)

    render json: data.as_json(
      include: {
        issue_settings: {
          only: [:setting_name, :setting_value]
        }
      },
      only: [:issue_id, :journal_id, :volume, :number, :year, :date_published]
    )

  end


end
