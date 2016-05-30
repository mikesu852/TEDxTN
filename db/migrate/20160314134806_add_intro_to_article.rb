class AddIntroToArticle < ActiveRecord::Migration
  def change
  	add_column :articles, :intro, :text
  end
end
