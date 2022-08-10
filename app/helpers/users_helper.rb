module UsersHelper
  def back_rout(user)
    if user != current_user
      return users_path
    end
    return posts_path
  end
end
