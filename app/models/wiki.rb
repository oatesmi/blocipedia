class Wiki < ApplicationRecord
  has_many :collaborators
  has_many :users, through: :collaborators

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 5 }, presence: true
  validates :private, inclusion: { in: [true, false ] }

  default_scope { order('created_at DESC') }

  def collaborators
    Collaborator.where(wiki_id: id)
  end

  def users
    collaborators.users
  end

end
