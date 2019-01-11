class Test < ApplicationRecord

  def self.get_by_category(categoty_title)
    joins('JOIN categories ON tests.category_id = categories.id')
        .where(categories: {title: categoty_title}).order(title: :desc).pluck(:title)
  end
end
