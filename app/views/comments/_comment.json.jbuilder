json.extract! comment, :id, :text, :post_id, :user_id, :reply_to, :created_at, :updated_at
json.url comment_url(comment, format: :json)
