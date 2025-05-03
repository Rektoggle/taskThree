Rails.application.routes.draw do
  root "home#index"

  # Ruta opcional si planeas buscar por título, aunque puede causar conflicto con slug si se parecen
  get '/tasks/title/:title', to: 'tasks#show_by_title', as: :task_by_title

  # Habilita todas las acciones REST con slug como identificador
  resources :tasks, param: :slug do
    resources :subtasks, only: [:create]
  end
end
