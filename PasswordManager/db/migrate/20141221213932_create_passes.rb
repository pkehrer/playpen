class CreatePasses < ActiveRecord::Migration
  def change
    create_table :passes do |t|
      t.string :name
      t.string :url
      t.string :password
      t.string :notes
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
