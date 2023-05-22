class PostQuery
  def self.find_by_category(category_id)
    if category_id.present?
      Post.where(category_id: category_id)
    else
      Post.all
    end
  end
end
