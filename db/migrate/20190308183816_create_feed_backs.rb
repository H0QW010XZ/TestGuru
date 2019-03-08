class CreateFeedBacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feed_backs do |t|
      t.references :user, foreign_key: true
      t.string :message

      t.timestamps
    end
  end
end
