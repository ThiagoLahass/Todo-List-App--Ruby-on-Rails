class TodoList < ApplicationRecord
  has_many :todo_items

  def percent_completed
    return 0 if total_items == 0
    @percent_completed = (100 * completed_items.to_f / total_items).round(1)
  end

  def completed_items
    @completed_items ||= todo_items.completed.count
  end

  def total_items
    @total_items ||= todo_items.count
  end

  def status
    case percent_completed.to_i
    when 0
      "Not started"
    when 100
      "Completed"
    else
      "In progress"
    end
  end

  def status_color
    case percent_completed.to_i
    when 0
      "dark"
    when 100
      "info"
    else
      "primary"
    end
  end

end