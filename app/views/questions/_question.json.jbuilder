json.extract! question, :id, :description, :option_count, :level_id, :created_at, :updated_at
json.url question_url(question, format: :json)