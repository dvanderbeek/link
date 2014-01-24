Linkcapital::Application.routes.draw do
  resources :applicants, only: [:index, :create]
  get :apply, to: 'applicants#new', as: :new_applicant
  get :apply, to: 'applicants#new', as: :apply

  %w[students investors organizations privacy_policy about_us terms_of_use].each do |path|
    get path, to: "home##{path}", as: path
  end
  get :contact, to: 'messages#new', as: :contact
  resources :messages, only: [:new, :create]
  resources :faqs,     only: [:index]
  root to: "home#index"
end
