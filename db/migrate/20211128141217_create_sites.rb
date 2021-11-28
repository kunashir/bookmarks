class CreateSites < ActiveRecord::Migration[6.1]
  def change
    create_table :sites do |t|
      t.string :url

      t.timestamps
    end
    add_index :sites, :url, unique: true
  end
end
