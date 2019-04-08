class CreateBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :badges do |t|
      t.string :name
      t.string :image_url
      t.string :criterion
      t.string :param

      t.timestamps
    end
  end
end
