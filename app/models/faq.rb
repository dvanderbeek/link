class Faq < ActiveRecord::Base
  attr_accessible :answer, :question
  validates :answer, :question, presence: true

  def self.search(search)
    if search
      where('question LIKE ? OR answer LIKE ?', "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end
end
