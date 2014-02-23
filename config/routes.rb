Linkcapital::Application.routes.draw do
  resources :applicants, only: [:index, :create]
  get :apply, to: 'applicants#new', as: :new_applicant
  get :apply, to: 'applicants#new', as: :apply

  %w[investors privacy_policy about_us terms_of_use].each do |path|
    get path, to: "home##{path}", as: path
  end
  get "borrowers", to: "home#students", as: :students
  get "employers", to: "home#organizations", as: :organizations
  
  get :contact, to: 'messages#new', as: :contact
  resources :messages, only: [:new, :create]
  resources :employer_contacts, only: [:create]
  resources :faqs,     only: [:index]
  root to: "home#index"
end