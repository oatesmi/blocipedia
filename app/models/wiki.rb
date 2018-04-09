class Wiki < ApplicationRecord
  has_many :users, through: :collabs

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 5 }, presence: true
  validates :private, inclusion: { in: [true, false ] }

  default_scope { order('created_at DESC') }

  def collabs
    Collab.where(wiki_id: id)
  end

  def users
    collabs.users
  end
end
