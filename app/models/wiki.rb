class Wiki < ApplicationRecord
  belongs_to :user
  has_many :users, through: :collaborators, dependent: :destroy

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 5 }, presence: true
  validates :private, inclusion: { in: [true, false ] }

  default_scope { order('created_at DESC') }


end
