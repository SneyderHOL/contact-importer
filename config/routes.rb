Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'
  get 'user/imported_files', to: 'user#imported_files'
  get 'import', to: 'import_file#import'
  post 'import', to: 'import_file#upload'
  get 'user/contacts', to: 'user#contacts'
  get 'imported_files/:id/failed_registers',
      to: 'import_file#failed_registers', as: "failed_registers"
end
