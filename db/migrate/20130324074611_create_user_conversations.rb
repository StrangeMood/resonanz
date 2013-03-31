class CreateUserConversations < ActiveRecord::Migration
  def change
    create_table :user_conversations do |t|
      t.integer :user_id
      t.integer :conversation_id
      t.integer :start_from, default: 0

      t.foreign_key :users, dependent: :delete
      t.foreign_key :conversations, dependent: :delete

      t.timestamps
    end

    add_index :user_conversations, :user_id
    add_index :user_conversations, :conversation_id
    add_index :user_conversations, :start_from
  end
end
