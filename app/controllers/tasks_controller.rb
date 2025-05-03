class TasksController < ApplicationController
    before_action :set_task, only: %i[show edit update destroy]
 
    def index
      @tasks = Task.all
    end


    def show
      @task = Task.find_by(slug: params[:slug])
      if @task.nil?
        redirect_to tasks_path, alert: "Tarea no encontrada"
      else
        @subtasks = @task.subtasks
        @subtask = Task.new  # Formulario para nueva subtarea
      end
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
        redirect_to task_path(@task.slug), notice: "Tarea creada con éxito."
      else
        render :index
      end
    end
  
    def edit
      @task = Task.find_by(slug: params[:slug])
      if @task.nil?
        redirect_to tasks_path, alert: "Tarea no encontrada."
      end
    end

    def update
      @task = Task.find_by(slug: params[:slug])
      
      if @task.update(task_params)
        redirect_to task_path(@task.slug), notice: "Tarea actualizada con éxito."
      else
        render :edit, alert: "Error al actualizar la tarea."
      end
    end
    
  
    def destroy
      @task = Task.find_by(slug: params[:slug])  # Cambiar de find a find_by
      if @task
        @task.destroy
        redirect_to tasks_path, notice: "Tarea eliminada exitosamente."
      else
        redirect_to tasks_path, alert: "Tarea no encontrada."
      end
    end
    
  
    private
  
    def set_task
      @task = Task.find_by(slug: params[:slug])
    end
    
  
    def task_params
      params.require(:task).permit(:title, :description, :parent_id)
    end
  end
  