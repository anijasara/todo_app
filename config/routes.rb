Rails.application.routes.draw do
  resources :templates do
    collection do
      get 'search_by_title'
    end
  end
  resources :tasks do
  	member do
      patch 'set_task_status'
    end
    collection do
      get 'get_tasks_by_status'
      get 'search_task_by_param'
    end
  end
  resources :lists do
    collection do
      get 'get_tasks'
      get 'search_by_name'
      post 'remove_tasks'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
