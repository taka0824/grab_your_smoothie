class Favorite < ApplicationRecord

  include Discard::Model
  default_scope -> { joins(:end_user).merge(EndUser.kept) }

  belongs_to :end_user
  belongs_to :smoothie
end
