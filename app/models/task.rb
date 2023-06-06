class Task < ApplicationRecord

  # Enums
  enum status: { created: 1, in_progress: 2, done: 3 }

  # Associations
  belongs_to :created_by, class_name: "User"
  belongs_to :assigned_to, class_name: "User", optional: true

  # Scopes
  scope :by_text, ->(text) do
    return all unless text.present?

    where_query = <<-SQL
      tasks.name ILIKE :text OR tasks.description ILIKE :text
    SQL

    where(where_query, text: "%#{text}%")
  end

  scope :by_status, ->(status) do
    return unless Task.statuses.include?(status)

    where(status: status)
  end
end
