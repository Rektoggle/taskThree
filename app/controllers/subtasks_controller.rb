# subtasks_controller.rb
class SubtasksController < ApplicationController
    before_action :set_task
  
    def create
      @subtask = Task.new(subtask_params)
      @subtask.parent_id = @task.id  # Asocia la subtarea con la tarea principal
  
      if @subtask.save
        redirect_to task_path(@task), notice: "Subtarea creada correctamente."
      else
        render "tasks/show", alert: "Error al crear la subtarea."
      end
    end
  
    private
  
    def set_task
      @task = Task.find(params[:task_id])
    end
  
    def subtask_params
      params.require(:task).permit(:title, :description)
    end
  end
  