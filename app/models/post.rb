class Post < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  mapping do
    indexes :title, type: 'text'
    indexes :subtitle, type: 'text'
    indexes :bich_text, type: 'text'
    indexes :user_name, type: 'text', fields: { keyword: { type: 'keyword' } }
    indexes :category_name, type: 'text', fields: { keyword: { type: 'keyword' } }
  end

  def as_indexed_json(_options = {})
    self.as_json(
      only: %i[id title subtitle bich_text],
      methods: [:user_name, :category_name]
    )
  end

  def user_name
    user&.name
  end

  def category_name
    category&.category
  end

  def self.search(query)
    response = __elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: %w[title subtitle bich_text user_name category_name]
          }
        }
      }
    )

    # Extract the source documents from the hits
    response.records.to_a.map(&:as_indexed_json)
  end




  # Create the Elasticsearch index if it doesn't exist
  Post.__elasticsearch__.create_index! unless Post.__elasticsearch__.index_exists?
end
