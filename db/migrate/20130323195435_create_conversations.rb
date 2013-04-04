class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.string :slug
      t.boolean :is_public, default: true
    end

    add_index :conversations, :slug, unique: true
  end
end
