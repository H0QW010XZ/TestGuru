class CreateBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :badges do |t|
      t.string :name, null: false
      t.string :image_url, null: false
      t.string :criterion, null: false
      t.string :param

      t.timestamps
    end
  end
end
