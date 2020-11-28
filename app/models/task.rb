class Task < ApplicationRecord
  belongs_to :list
  has_many :template_tasks
  has_many :templates, :through => :template_tasks

  validates_uniqueness_of :task_id
  validates_presence_of :name, :task_id, :due_at

  def self.get_task_by_params(param_name, param_val)
    self.where("#{param_name}": param_val)
  end
end
