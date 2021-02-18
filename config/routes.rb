Sample::Application.routes.draw do

  devise_for :users, :path => "auth", :path_names => { :sign_in => 'login', :sign_out => 'logout',
    :password => 'secret', :confirmation => 'verification', :registration => 'register' }, :controllers => {:registrations => "authentication"}

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :users do
    member do
      put 'toggle_status'
    end
  end

  resources :solutions do
    member do
      put 'toggle_status'
    end
    collection do
      get 'search_authors'
      get 'search_specs'
    end
  end

  resources :home

  resources :solution_specializations do
    member do
      put 'toggle_status'
    end
  end
end
