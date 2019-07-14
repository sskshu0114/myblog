class PostsController < ApplicationController
  before_action :set_post,only: [ :show, :edit, :update, :destroy]

  def index
  # 記事一覧用

  @q = Post.order(created_at: :desc).ransack(params[:q])
  @posts = @q.result.page(params[:page]).per(2)
  # 最新記事用
  @new_posts = Post.order(created_at: :desc).limit(5)
  @author = Author.first
  end

  def show
  end

  def new
    @post = Post.new # フォーム用の空のインスタンスを生成する。
  end

  def create
    @post = Post.new(post_params) # ストロングパラメータを引数に
    @post.save # saveをしてデータベースに保存する。
    redirect_to @post # showページにリダイレクト
  end

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to @post
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params # ストロングパラメータを定義する
    params.require(:post).permit(:title, :body, :category)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
