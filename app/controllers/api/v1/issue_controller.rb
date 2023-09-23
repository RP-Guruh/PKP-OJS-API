class Api::V1::IssueController < Api::V1::AuthenticatedController

  # Mendapatkan semua issue dari semua journal
  def getAllIssue
    result_array = []

    allIssue = Issue.all

    allIssue.each do |data|
      issue_doi = IssueSetting.where(issue_id: data.issue_id).where(setting_name: 'pub-id::doi').first
      issue_cover = IssueSetting.where(issue_id: data.issue_id).where(setting_name: 'coverImage').first
      issue_desc = IssueSetting.where(issue_id: data.issue_id).where(setting_name: 'description').first
      issue_title = IssueSetting.where(issue_id: data.issue_id).where(setting_name: 'title').first

      result_hash = {
        issue_id: data.issue_id,
        journal_id: data.journal_id,
        volume: data.volume,
        number: data.number,
        year: data.year,
        doi: issue_doi&.setting_value,
        cover: issue_cover&.setting_value,
        desc: issue_desc&.setting_value,
        title: issue_title&.setting_value
      }
      result_array << result_hash
    end

    render json: result_array
  end

  # Mendapatkan semua issue berdasarkan id jurnal
  def getAllIssueByJournal
    journal_id = params[:id]

    result_array = []

    allIssue = Issue.where(journal_id: journal_id).all

    allIssue.each do |data|
      issue_doi = IssueSetting.where(issue_id: data.issue_id).where(setting_name: 'pub-id::doi').first
      issue_cover = IssueSetting.where(issue_id: data.issue_id).where(setting_name: 'coverImage').first
      issue_desc = IssueSetting.where(issue_id: data.issue_id).where(setting_name: 'description').first
      issue_title = IssueSetting.where(issue_id: data.issue_id).where(setting_name: 'title').first

      result_hash = {
        issue_id: data.issue_id,
        journal_id: data.journal_id,
        volume: data.volume,
        number: data.number,
        year: data.year,
        doi: issue_doi&.setting_value,
        cover: issue_cover&.setting_value,
        desc: issue_desc&.setting_value,
        title: issue_title&.setting_value
      }
      result_array << result_hash
    end

    render json: result_array

  end

  # Mendaptkan issue berdasarkan id issue nya
  def getIssueByID
    issue_id = params[:id]

    result_array = []

    allIssue = Issue.where(issue_id: issue_id).first

    issue_doi = IssueSetting.where(issue_id: issue_id).where(setting_name: 'pub-id::doi').first
    issue_cover = IssueSetting.where(issue_id: issue_id).where(setting_name: 'coverImage').first
    issue_desc = IssueSetting.where(issue_id: issue_id).where(setting_name: 'description').first
    issue_title = IssueSetting.where(issue_id: issue_id).where(setting_name: 'title').first

    result_hash = {
      issue_id: allIssue&.issue_id,
      journal_id: allIssue&.journal_id,
      volume: allIssue&.volume,
      number: allIssue&.number,
      year: allIssue&.year,
      doi: issue_doi&.setting_value,
      cover: issue_cover&.setting_value,
      desc: issue_desc&.setting_value,
      title: issue_title&.setting_value
    }
    result_array << result_hash

    render json: result_array

  end

end
