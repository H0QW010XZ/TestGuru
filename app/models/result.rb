class Result < ApplicationRecord
  validates :score, presence: true

  belongs_to :test
  belongs_to :user
end
