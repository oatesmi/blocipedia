class ChangeCollaborators < ActiveRecord::Migration[5.1]
  def change
    add_index :collaborators, :id, unique: true
  end
end
