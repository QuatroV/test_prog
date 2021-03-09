Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "index#choose_license"
  get "index/choose_license"
  post "index/get_versions"
  post "index/new_license"
end
