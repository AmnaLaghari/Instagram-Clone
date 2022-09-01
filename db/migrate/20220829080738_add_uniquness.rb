class AddUniquness < ActiveRecord::Migration[5.2]
  def change
  end
  add_index :requests, %i[sender_id reciever_id], unique: true
end
