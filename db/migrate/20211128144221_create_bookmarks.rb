class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.string :title, index: true
      t.text :url, index: true
      t.string :shortening
      t.belongs_to :site, null: false, foreign_key: true

      t.timestamps
    end
  end
end
