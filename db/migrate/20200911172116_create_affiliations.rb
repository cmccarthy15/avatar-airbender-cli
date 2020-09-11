class CreateAffiliations < ActiveRecord::Migration[6.0]
  def change
    create_table :affiliations do |t|
      t.integer :character_id
      t.integer :nation_id
    end
  end
end
