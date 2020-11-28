class TemplateTask < ApplicationRecord
  belongs_to :template
  belongs_to :task
end
