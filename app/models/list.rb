class List < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :template_lists
  has_many :templates, :through => :template_lists

  validates_uniqueness_of :list_id
  validates_presence_of :name, :list_id

  def self.delete_tasks(task_ids)
    true if task_ids.map {|id| Task.delete(id)}
  end
end
