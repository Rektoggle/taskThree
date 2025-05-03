class Task < ApplicationRecord
  belongs_to :parent, class_name: 'Task', optional: true
  has_many :subtasks, class_name: 'Task', foreign_key: 'parent_id'

  def depth
    parent ? parent.depth + 1 : 0
  end

  # Validar que no haya más de 5 niveles de subtareas
  validate :max_subtask_depth

  private

  def max_subtask_depth
    if depth >= 5
      errors.add(:base, "No se pueden crear subtareas más allá del quinto nivel.")
    end
  end
end
