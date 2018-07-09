class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  #로그인해야 글쓰기가 됨
  before_action :authenticate_user!, except: :index
  load_and_authorize_resource

  def index
    #@posts = Post.all.page(1).per(5)
    @posts = Post.order(created_at: :desc).page(params[:page]).per(3)
    respond_to do |format|
      format.html {render 'index'}  #' index' 생략 가능
      format.json{ render json: @posts  }
    end
  end

  def new
    @post = Post.new
  end

  def create
    # if params[:title].nil? or params[:content].nil?
    #   flash[:alert] = "title이나 content를 채워주세요."
    #   redirect_to :back
    # else

      @post = current_user.posts.new(post_params)
      respond_to do |format|
        if @post.save
          # 저장이 되었을 경우에 실행
          format.html { redirect_to '/', notice: "글 작성 완료"}
        else
          # 저장이 실패했을 경우에(validation)에 걸렸을 때 실행
          # flash[:alert] = "글 작성이 실패하였습니다."
          # redirect_to new_post_path   # new_post_path는 '/posts/new' 경로랑 같은거임
          format.html { render :new }
          format.json { render json: @post.errors}
        end
      end
    #@post = Post.new(post_params)
  end

  def show
    @comments = @post.comments
    #authorize! :show, @post
  end

  def edit
    # if current_user.id == @post.user.id
    # else
    #   redirect_to '/'
    # end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "글 수정 완료"}
      else
        format.html { render :edit }
        format.json { render json: @post.errors}
      end
    end
    #authorize! :update, @post
  end

  def destroy
    @post.destroy
    redirect_to "/"
  end

  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    # params.permit(:title, :content)
    params.require(:post).permit(:title, :content, :img)
  end
end
