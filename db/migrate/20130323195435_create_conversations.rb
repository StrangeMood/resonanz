class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.string :slug
      t.boolean :public
    end
  end
end
