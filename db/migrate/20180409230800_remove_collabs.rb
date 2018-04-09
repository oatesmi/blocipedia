class RemoveCollabs < ActiveRecord::Migration[5.1]
  def change
    drop_table :collabs
  end
end
