class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @categories = Category.all
    @posts = Post.paginate(page: params[:page], per_page: 9)
  end

  # GET /posts/1 or /posts/1.json
  def show
    if params[:id] == "filter_by_category"
      # Handle the case when the ID is "filter_by_category"
      # Redirect or render a different view
      redirect_to posts_path, notice: "Invalid post ID"
    else
      @post = Post.find(params[:id])
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  def filter_by_category
    category_id = params[:category_id]
    if category_id.present?
      @category = Category.find(category_id)
      @posts = @category.posts.paginate(page: params[:page], per_page: 5)
    else
      @posts = Post.paginate(page: params[:page], per_page: 5)
    end
    @categories = Category.all

    respond_to do |format|
      format.html { render :index }
      format.js { render :index }
    end
  end


  def search
    @posts = Post.search(params[:q])

    respond_to do |format|
      format.json { render json: @posts }
    end
  end


  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.category = Category.find(params[:post][:category_id])

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :subtitle, :bich_text, :user_id, :comments, :category_id)
    end
end
