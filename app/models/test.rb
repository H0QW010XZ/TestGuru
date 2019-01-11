class Test < ApplicationRecord

  def self.get_by_category(c)
    joins('JOIN categories ON tests.category_id = categories.id')
        .where(categories: {title: c}).order(title: :desc).pluck(:title)
  end
end
