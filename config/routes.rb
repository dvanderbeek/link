Linkcapital::Application.routes.draw do
  
  %w[students investors organizations apply].each do |path|
    get path, to: "home##{path}", as: path
  end
  get :contact, to: 'messages#new', as: :contact
  resources :messages, only: [:new, :create]
  resources :faqs,     only: [:index]
  root to: "home#index"
end
