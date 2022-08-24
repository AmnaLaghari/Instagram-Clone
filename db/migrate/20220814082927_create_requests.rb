# frozen_string_literal: true

class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :sender_id, null: false, index: true
      t.integer :reciever_id, null: false, index: true

      t.timestamps
    end
    add_foreign_key :requests, :users, column: :sender_id
    add_foreign_key :requests, :users, column: :reciever_id
  end
end
