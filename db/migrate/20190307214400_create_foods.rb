class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :dish
      t.string :description
      t.belongs_to :rest, foreign_key: true

      t.timestamps
    end
  end
end
