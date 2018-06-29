class CommentsController < ApplicationController

  def create
    @comment = Post.find(params[:post_id]).comments.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      respond_to do |format|
        format.html {redirect_to :back}
        format.js {render 'create_temp'}   #이걸 해야만 액션명과 동일한 js.erb 파일을 랜더링한다. 액션명과 다를경우 이렇게 렌더명을 지정함
      end
    else
      redirect_to :back
    end
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    @comment.destroy
    respond_to do |format|
      format.html {redirect_to :back}
      format.js {}
    end
  end

  private
  def comment_params
    params.permit(:content)
  end
end
