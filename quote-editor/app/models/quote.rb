class Quote < ApplicationRecord
  has_many :line_item_dates, dependent: :destroy
  has_many :line_items, through: :line_item_dates

  belongs_to :company

  validates :name, presence: true

  scope :ordered, -> { order(id: :desc) }

  broadcasts_to ->(quote) { [quote.company, "quotes"] }, inserts_by: :prepend

  include PgSearch::Model
  pg_search_scope :search_name, against: :name

  def self.search(search)
    Quote.search_name(search)
  end

  def total_price
    line_items.sum(&:total_price)
  end
end