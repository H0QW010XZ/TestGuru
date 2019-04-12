class Badge < ApplicationRecord
  enum criterions: %i[first_try all_category all_level]

  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  validates :name, :image_url, :criterion, :param, presence: true

  validates :criterion, uniqueness: { scope: :param }
end
