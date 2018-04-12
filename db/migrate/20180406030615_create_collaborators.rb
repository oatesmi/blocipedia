class CreateCollaborators < ActiveRecord::Migration[5.1]
  def change
    create_table :collaborators do |t|
      t.string :email
      t.references :user, index: true, foreign_key: true
      t.references :wiki, index: true, foreign_key: true
    end
  end
end
