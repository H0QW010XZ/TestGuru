class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User'
  has_many :questions, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :users, through: :results, dependent: :destroy

  def self.get_by_category(category_title)
    joins(:category)
      .where(categories: {title: category_title})
      .order(title: :desc)
      .pluck(:title)
  end
end
