Rails.application.routes.draw do
  root "notes#index"

  resources :notes, path: "", except: [:index] # Sin prefijo "notes"
end
