class Badge < ApplicationRecord
  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  enum criterions: %i[first_try all_category all_level]

  validates :name, :image_url, :criterion, :param, presence: true

  validates :criterion, uniqueness: { scope: :param }
end
