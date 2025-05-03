# subtasks_controller.rb
class SubtasksController < ApplicationController
    before_action :set_task
  
    def create
      if @task.depth >= 5
        redirect_to task_path(@task), alert: "Límite de subniveles alcanzado."
      else
        @subtask = Task.new(subtask_params)
        @subtask.parent_id = @task.id
        if @subtask.save
          redirect_to task_path(@task), notice: "Subtarea creada correctamente."
        else
          render "tasks/show", alert: "Error al crear la subtarea."
        end
      end
    end
    
  
    private
  
    def set_task
      @task = Task.find(params[:task_id])
    end
  
    def subtask_params
      params.require(:task).permit(:title, :description)
    end

    skip_before_action :verify_authenticity_token, only: [:create]

  end
  