class CommentsController < ApplicationController
  def create
    Comment.create(content: comment_params[:content], user_id: current_user.id, item_id: params[:id])
    flash[:success] = 'コメントを作成しました'
    redirect_to item_path
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content)
  end  
end
