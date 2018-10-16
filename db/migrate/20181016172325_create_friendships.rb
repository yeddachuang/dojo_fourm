class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :inviter_id
      t.integer :invitee_id
      t.string :status
      t.timestamps
    end
  end
end
