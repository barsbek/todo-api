json.(todo,
  :id,
  :title,
  :list_id,
  :completed,
  :updated_at
)
json.url api_v1_todo_url(todo, format: :json)
