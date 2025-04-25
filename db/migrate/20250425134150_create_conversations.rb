class CreateConversations < ActiveRecord::Migration[8.0]
  def change
    create_table :conversations do |t|
      t.belongs_to :sender, null: false, foreign_key: { to_table: :users }
      t.belongs_to :recipient, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :conversations, [:sender_id, :recipient_id], unique: true
  end
end