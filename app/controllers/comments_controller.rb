class CommentsController < ApplicationController
  def create
    @spot = Spot.find(params[:spot_id])
    @comment = @spot.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to spot_path(@spot), notice: '投稿に失敗しました' }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:spot_id, :content)
  end
end
