class User < ApplicationRecord
  validates :name, :email, presence: true

  has_many :results
  has_many :tests, through: :results, dependent: :destroy
  has_many :creator, class_name: 'Test',foreign_key: 'author_id', dependent: :destroy
  has_many :created_tests, class_name: 'Test',foreign_key: 'author_id', dependent: :destroy

  def by_level(level)
    tests.where(level: level)
  end
end
