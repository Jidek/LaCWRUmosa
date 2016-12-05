class StatisticsController < ApplicationController

  def index
    @friends_query = Benchmark.measure{User.all.first.friends}.to_s.gsub(')', '').gsub('(', '').split(' ')
    @events_query = Benchmark.measure{Event.joins(:invites).where('invites.user_id' => session[:cas_user], 'invites.rsvp' => Invite.rsvps[:accepted]).joins(:location)}.to_s.gsub(')', '').gsub('(', '').split(' ')
    @locations_query = Benchmark.measure{@locations = Location.joins(:indoor_location).includes(:ratings)}.to_s.gsub(')', '').gsub('(', '').split(' ')
  end
end
