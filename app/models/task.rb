class Task < ApplicationRecord
  has_many :subtasks, class_name: "Task", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent, class_name: "Task", optional: true

  # Valida si es una tarea principal o una subtarea
  def main_task?
    parent_id.nil?
  end

  # Validar que no haya más de 3 niveles de subtareas
  validate :max_subtask_depth

  private

  def max_subtask_depth
    if parent && parent.parent && parent.parent.parent
      errors.add(:base, "No se pueden crear subtareas más allá del tercer nivel.")
    end
  end


end
