class Faq < ActiveRecord::Base
  attr_accessible :answer, :question
  validates :answer, :question, presence: true

  include PgSearch
  pg_search_scope :search, against: [:question, :answer],
    using: {tsearch: {dictionary: "simple"}} #use english for dictionary if we want to ignore stop words like "of" and "the" and allow stemming

  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end
end
