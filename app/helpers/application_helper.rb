module ApplicationHelper

  def create_verbose_name_list(event)
    users = event.invites.map{|invite| invite.user}
    return "#{users.first.name} is " if users.length == 1
    return "#{users.first.name} and #{users.second.name} are " if users.length == 2
    return users[0..-2].join(", ") + ", and #{users.last.name} are "
  end

end
