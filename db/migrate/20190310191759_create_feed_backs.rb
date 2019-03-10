class CreateFeedBacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feed_backs do |t|
      t.string :name
      t.string :email
      t.text :message
    end
  end
end
