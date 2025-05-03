class TasksController < ApplicationController
    before_action :set_task, only: %i[show edit update destroy]
  
    def show
      @subtask = Task.new  # Esto es para el formulario de subtarea
      @subtasks = @task.subtasks
    end

    def index
      @task = Task.new
      @tasks = Task.where(parent_id: nil) # Solo tareas principales
    end

    def show_by_title
      @task = Task.find_by("lower(title) = ?", params[:title].tr('-', ' ').downcase)
      if @task
        @subtasks = @task.subtasks
        render :show
      else
        redirect_to root_path, alert: "Tarea no encontrada"
      end
    end

    def new
      @task = Task.new(parent_id: params[:parent_id])
    end
  
    def create
      @task = Task.new(task_params)
      if @task.save
        redirect_to tasks_path, notice: "Tarea creada correctamente."
      else
        @tasks = Task.where(parent_id: nil)
        render :index, status: :unprocessable_entity
      end
    end
  
    def edit
      @task = Task.find(params[:id])
    end
    
    def update
      @task = Task.find(params[:id])
      if @task.update(task_params)
        redirect_to tasks_path, notice: "Tarea actualizada correctamente."
      else
        render :edit, status: :unprocessable_entity
      end
    end
    
  
    def destroy
      @task = Task.find(params[:id])
      @task.destroy
      redirect_to tasks_path, notice: "Tarea eliminada exitosamente."
    end
  
    private
  
    def set_task
      @task = Task.find(params[:id])
    end
  
    def task_params
      params.require(:task).permit(:title, :description, :parent_id)
    end
  end
  