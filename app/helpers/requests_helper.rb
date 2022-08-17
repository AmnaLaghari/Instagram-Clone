# frozen_string_literal: true

module RequestsHelper
  def requested?(requests, user)
    requests.each do |request|
      return true if request.reciever_id.eql? user.id
    end
    false
  end

  def user_details(id)
    User.find(id)
  end
end
