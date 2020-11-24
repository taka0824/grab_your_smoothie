class Admins::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @comments = Comment.all.order(created_at: "DESC")
  end

  def todays_comments
    range = Date.today.beginning_of_day..Date.today.end_of_day
    @comments = Comment.where(created_at: range)
  end

  def destroy
    comment = Comment.find(params[:id])
    end_user = comment.end_user
    comment.destroy
    end_user.rule_violation_number += 1
    end_user.save
    if end_user.rule_violation_number == 3
      end_user.smoothies.destroy_all
      end_user.comments.destroy_all
      end_user.favorites.destroy_all
      end_user.juicer_ingredients.destroy_all
      end_user.update(is_deleted: true, name: "#{end_user.name}" + "(規約違反により退会)")
    end
    redirect_to admins_comments_path
  end

end
