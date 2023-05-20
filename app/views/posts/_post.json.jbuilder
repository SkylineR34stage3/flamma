json.extract! post, :id, :title, :subtitle, :bich_text, :user_id, :comments, :category, :created_at, :updated_at
json.url post_url(post, format: :json)
