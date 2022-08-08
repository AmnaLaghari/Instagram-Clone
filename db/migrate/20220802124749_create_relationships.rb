# frozen_string_literal: true

class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followee_id
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :relationships, :followee_id,                unique: true
    add_index :relationships, :follower_id,                unique: true
  end
end
