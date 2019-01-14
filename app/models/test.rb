class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User'
  has_many :questions, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :users, through: :results, dependent: :destroy

  scope :easy_level, -> { where(level: 0..1) }
  scope :middle_level, -> { where(level: 2..4) }
  scope :hard_level, -> { where(level: 5..Float::INFINITY) }

  scope :tests_by_category, lambda { |category_title|
    joins(:category)
      .where(categories: { title: category_title })
      .order(title: :desc)
      .pluck(:title)
  }

  validates :title, uniqueness: {scope: :level}
  validates :title, :level, presence: true
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

end
