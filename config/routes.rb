Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'
  get 'user/imported_files', to: 'user#imported_files'
  get 'import', to: 'import_file#import'
  post 'import', to: 'import_file#upload'
  resources :contacts, only: [:index]
  #get 'failed_registers', to: ''
end
