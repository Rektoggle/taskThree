Rails.application.routes.draw do
  root "home#index"

  # Ruta personalizada para ver tareas por título (antes que resources :tasks)
  get '/tasks/title/:title', to: 'tasks#show_by_title', as: :task_by_title

  # Las rutas REST normales
  resources :tasks, param: :slug do
    resources :subtasks, only: [:create]
  end  
end
