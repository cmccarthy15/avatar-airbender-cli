class CreateCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :characters do |t|
      t.string :api_id
      t.string :name
      t.string :photo_url
      t.boolean :is_avatar
    end
  end
end
