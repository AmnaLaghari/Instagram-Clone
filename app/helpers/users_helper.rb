# frozen_string_literal: true

module UsersHelper
  def back_rout(user)
    return users_path if user != current_user

    posts_path
  end

  def select_avatar(user)
    return user.avatar if user.avatar.attached?
    'user.png'
  end
end
