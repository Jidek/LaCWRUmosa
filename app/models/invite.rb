class Invite < ActiveRecord::Base

  self.primary_keys = :user_id, :event_id

  belongs_to :event
  belongs_to :user

  enum rsvp: {no_response: 0, accepted: 1, rejected: 2}
end
