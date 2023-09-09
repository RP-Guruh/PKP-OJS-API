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
      # get '/publications'  SEMUA PUBLIKASI PADA JURNAL
      # get '/publication/:id' PUBLIKASI JURNAL BERDASARKAN ID PUBLIKASI NYA
      # get '/publication/journal/:id' SEMUA PUBLIKASI BERDASARKAN JURNAL NYA MASING MASING

    end
  end
end
