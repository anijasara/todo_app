class Template < ApplicationRecord
  has_many :template_tasks
  has_many :tasks, :through => :template_tasks

  has_many :template_lists
  has_many :lists, :through => :template_lists

  validates_uniqueness_of :template_id
  validates_presence_of :name, :template_id
end
