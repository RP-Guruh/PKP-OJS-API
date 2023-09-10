Rails.application.routes.draw do
  devise_for :api_users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :api_token, only: [:index, :create, :update, :destroy]
  namespace :api do
    namespace :v1 do
      #   Issue API
      get '/issues', to: 'issue#getAllIssue'
      get '/issue_by_journal/:id', to: 'issue#getAllIssueByJournal'
      get '/issue/:id', to: 'issue#getIssueByID'

      #   Journal API
      get '/journals', to: 'journal#getAllJournal'
      get '/journal/:id', to: 'journal#getJournalByID'

      #  Article API
      get '/publications', to: 'publication#getAllPublication'  # SEMUA PUBLIKASI PADA JURNAL
      get '/publication/:id', to: 'publication#getPublicationById' #PUBLIKASI JURNAL BERDASARKAN ID PUBLIKASI NYA
      get '/publication/limit/:limit', to: 'publication#getAllPublicationByLimit' #PUBLIKASI JURNAL BERDASARKAN ID PUBLIKASI NYA
      get '/publication/journal/:id', to: 'publication#getAllPublicationByJournal' # SEMUA PUBLIKASI BERDASARKAN JURNAL NYA MASING MASING
      get '/publication/journal/:journal/issue/:issue', to: 'publication#getAllPublicationByIssue'
    end
  end
end
