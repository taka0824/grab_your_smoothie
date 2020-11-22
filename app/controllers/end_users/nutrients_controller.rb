class EndUsers::NutrientsController < ApplicationController
  before_action :authenticate_end_user!
end
