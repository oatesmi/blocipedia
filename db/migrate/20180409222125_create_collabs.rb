class CreateCollabs < ActiveRecord::Migration[5.1]
  def change
    create_table :collabs do |t|
      t.integer :wiki_id
      t.integer :user_id
      t.timestamps
    end

    add_index :wikis, :id, unique: true
    add_index :users, :id, unique: true
    add_index :collabs, :id, unique: true
    add_index :collabs, :user_id
    add_index :collabs, :wiki_id
  end
end
