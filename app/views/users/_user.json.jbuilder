json.extract! user, :id, :name, :lastname, :comments, :role_id, :posts, :created_at, :updated_at
json.url user_url(user, format: :json)
