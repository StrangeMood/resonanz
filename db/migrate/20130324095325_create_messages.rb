class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :text
      t.integer :author_id
      t.integer :conversation_id

      t.foreign_key :conversations, dependent: :delete

      t.timestamps
    end
  end
end
