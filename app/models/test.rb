class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User'

  has_many :questions, dependent: :destroy
  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages, dependent: :destroy

  validates :title, uniqueness: { scope: :level }, presence: true
  validates :level, presence: true
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :easy_level, -> { where(level: 0..1) }
  scope :middle_level, -> { where(level: 2..4) }
  scope :hard_level, -> { where(level: 5..Float::INFINITY) }

  scope :tests_by_category, lambda { |category_title|
    joins(:category)
        .where(categories: { title: category_title })
        .order(title: :desc)
  }

  scope :successful_by_level, lambda { |level|
    joins(:test_passages)
        .where(level: level)
        .order(:id)
  }

  scope :successful_by_category, lambda { |id|
    joins(:test_passages)
        .where(category_id: id)
        .order(:id)
  }

  def self.by_category(category_title)
    tests_by_category(category_title).pluck(:title)
  end

  def self.all_levels
    all.pluck(:level)
  end
end
