class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :title
      t.integer :views,:default => '0'
      t.string :category
      t.string :place
      t.datetime :date
      t.string :thumb
      t.text :content
      t.text :summary
      t.timestamps null: false
    end
  end
end
