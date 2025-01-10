class TodoItem < ApplicationRecord
  belongs_to :todo_list

  before_save :set_completed_at, if: :completed_changed?

  scope :completed, -> do
    where(completed: true)
  end

  def set_completed_at
    if completed
      self.completed_at = Time.current
    else
      self.completed_at = nil
    end
  end
end
