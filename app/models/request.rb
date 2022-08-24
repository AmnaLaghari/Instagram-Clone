# frozen_string_literal: true

class Request < ApplicationRecord
  belongs_to :sender, class_name: :User, inverse_of: :sent_requests
  belongs_to :reciever, class_name: :User, inverse_of: :recieved_requests
end
