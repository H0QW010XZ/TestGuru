class Result < ApplicationRecord
  belongs_to :test
  belongs_to :user

  validates :score, presence: true
end
