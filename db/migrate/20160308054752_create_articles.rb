class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.integer :views,:default => '0'
      t.string :category

      t.timestamps null: false
    end
  end
end
