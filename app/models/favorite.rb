class Favorite < ApplicationRecord
  belongs_to :end_user
  include Discard::Model
  default_scope -> { joins(:end_user).merge(EndUser.kept) }
  belongs_to :smoothie
end
