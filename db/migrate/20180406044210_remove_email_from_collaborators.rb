class RemoveEmailFromCollaborators < ActiveRecord::Migration[5.1]
  def change
    remove_column :collaborators, :email, :string
  end
end
