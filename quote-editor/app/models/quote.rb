class Quote < ApplicationRecord
  has_many :line_item_dates, dependent: :destroy
  
  belongs_to :company

  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }

  broadcasts_to ->(quote) { [quote.company, "quotes"] }, inserts_by: :prepend

  include PgSearch::Model
  pg_search_scope :search_name, against: :name

  def self.search(search)
    Quote.search_name(search)
  end
end