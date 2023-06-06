class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :status, :created_by

  def created_by
    object.created_by.first_name + ' ' + object.created_by.last_name
  end
end
