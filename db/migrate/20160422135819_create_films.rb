class CreateFilms < ActiveRecord::Migration
  def change
    create_table :films do |t|
      t.string :title
      t.integer :views,:default => '0'
      t.string :year
      t.string :event
      t.text :summary
      t.string :url
      t.string :category
      t.timestamps null: false
    end
    add_column :films, :user_id, :integer
    add_index :films, :user_id
  end
end
