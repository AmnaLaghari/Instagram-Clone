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

  # def accept_request(user)
  #   ActiveRecord::Base.transaction do
  #     if current_user.following_users.create!(follower_id: user.id)
  #       user.sent_requests.find_by(reciever_id: current_user.id).destroy
  #       redirect_to user_path(user.id), notice: 'Request accepted successfully'
  #     else
  #       redirect_to user_path(user.id),
  #                   notice: "Request was not accepted successfully.#{followed_users.errors.full_messages.to_sentence}"
  #     end
  #   end
  # rescue ActiveRecord::RecordInvalid
  #   redirect_to user_path(user.id), notice: 'Something went wrong.'
  # end

  # def delete_request(user)
  #   sent_requests.find_by(reciever_id: user.id).destroy
  # end
end
