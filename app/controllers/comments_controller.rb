class CommentsController < ApplicationController
  def create
    Comment.create(content: comment_params[:content], user_id: current_user.id, item_id: params[:item_id])
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content)
  end  
end
