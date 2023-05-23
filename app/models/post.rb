class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: {
    analysis: {
      filter: {
        edge_ngram_filter: {
          type: 'edge_ngram',
          min_gram: 1,
          max_gram: 20
        }
      },
      analyzer: {
        edge_ngram_analyzer: {
          type: 'custom',
          tokenizer: 'standard',
          filter: %w[lowercase edge_ngram_filter]
        }
      }
    }
  } do
    mapping do
      indexes :id, type: 'integer'
      indexes :title, type: 'text', analyzer: 'edge_ngram_analyzer', search_analyzer: 'standard'
      indexes :subtitle, type: 'text', analyzer: 'edge_ngram_analyzer', search_analyzer: 'standard'
      indexes :bich_text, type: 'text', analyzer: 'edge_ngram_analyzer', search_analyzer: 'standard'
      indexes :user_name, type: 'text', analyzer: 'edge_ngram_analyzer', search_analyzer: 'standard', fields: { keyword: { type: 'keyword' } }
      indexes :category_name, type: 'text', analyzer: 'edge_ngram_analyzer', search_analyzer: 'standard', fields: { keyword: { type: 'keyword' } }
    end
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
    query_terms = query.split

    response = __elasticsearch__.search(
      {
        query: {
          bool: {
            should: query_terms.map { |term|
              {
                multi_match: {
                  query: term,
                  fields: %w[title subtitle bich_text user_name category_name]
                }
              }
            }
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
