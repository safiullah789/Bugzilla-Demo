class AddColumnToBugs < ActiveRecord::Migration[5.2]
  def change
    add_column :bugs, :dev_id, :int
  end
end
