json.extract! task, :id, :task_id, :name, :description, :status, :done_at, :due_at, :list_id, :created_at, :updated_at
json.url task_url(task, format: :json)