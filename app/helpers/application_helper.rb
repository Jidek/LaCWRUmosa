module ApplicationHelper

  def create_verbose_name_list(event)
    users = event.invites.map{|invite| invite.user}

    return "#{link_to users.first.name, user_path(users.first)} is" if users.length == 1
    return "#{link_to users.first.name, user_path(users.first)} and #{link_to users.second.name, user_path(users.second)} are" if users.length == 2
    return users[0..-2].map{|user| link_to user.name, user_path(user)}.join(", ") + ", and #{link_to users.last.name, user_path(users.last)} are"
  end

end
