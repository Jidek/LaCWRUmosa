module ApplicationHelper

  def create_verbose_name_list(event)
    users = event.invites.map{|invite| invite.user}

    return "#{link_to users.first.name, user_path(users.first)} is" if users.length == 1
    return "#{link_to users.first.name, user_path(users.first)} and #{link_to users.second.name, user_path(users.second)} are" if users.length == 2
    return users[0..-2].map{|user| link_to user.name, user_path(user)}.join(", ") + ", and #{link_to users.last.name, user_path(users.last)} are"
  end

  def print_miles(distance)
    if distance >= 1
      return "#{distance.round(2)} miles"
    else
      return "#{(distance*5280).round(0)} feet"
    end
  end

  def print_with_count(text, records)
    if records > 0
      return "#{text} (#{records})"
    else
      return text
    end
  end

end
