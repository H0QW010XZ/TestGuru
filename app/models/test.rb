class Test < ApplicationRecord
  belongs_to :category
  has_many :question
  has_many :results

  def self.get_by_category(c)
    Test.joins('JOIN categories ON tests.category_id = categories.id')
        .where(categories: {title: c}).pluck(:title).sort
  end
end
