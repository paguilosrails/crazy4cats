class AddColumnsToReactions < ActiveRecord::Migration[7.0]
  def change
    add_column :reactions, :reaction_type, :string
  end
end
