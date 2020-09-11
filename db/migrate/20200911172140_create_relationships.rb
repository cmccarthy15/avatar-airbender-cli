class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.integer :character_one_id
      t.integer :character_two_id
      t.boolean :are_enemies
      t.boolean :are_allies
    end
  end
end
