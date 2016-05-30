class ArticlesController < ApplicationController
  before_action :check_login,only: %i[new]
  before_action :find_article, only: %i[show edit update destroy open close]

  def index
    @article  = Article.where({status: "0",created_at: 60.days.ago..Time.now }).order("RANDOM()").limit(6)
    @articleA = Article.where("status = 0 AND category LIKE ?","策展觀點").order('created_at DESC').limit(4)
    @articleB = Article.where("status = 0 AND category LIKE ?","十八分放大").order('created_at DESC').limit(4)
    @articleC = Article.where("status = 0 AND category LIKE ?","一百種臺南").order('created_at DESC').limit(4)
    @articleD = Article.where("status = 0 AND category LIKE ?","實踐者").order('created_at DESC').limit(4)
    @articleE = Article.where("status = 0 AND category LIKE ?","值得議題").order('created_at DESC').limit(4)
    @activities = Activity.where("status = 0").order('created_at DESC').limit(4)
    @hot = Article.where("status = 0").order("views DESC").first
	end

	def new
    @article = Article.new
  end

  def create
    @article= Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def show
    prepare_meta_tags(title: @article.title,
                      description: @article.summary,
                      image: @article.thumb.url(:large),
                      keywords: @article.tag_list,
                      og: { image: @article.thumb.url(:large),
                            description: @article.summary})
    @morearticles = Article.where("status = 0").tagged_with(@article.tag_list).order("RANDOM()").limit(4)
    @article.views+=1
    @article.save
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to users_path }
      format.js
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def columns
    @article=Article.where("status = 0")
    @articleA = Article.where("status = 0 AND category LIKE ?","策展觀點").order('created_at DESC').first
    @articleB = Article.where("status = 0 AND category LIKE ?","十八分放大").order('created_at DESC').first
    @articleC = Article.where("status = 0 AND category LIKE ?","一百種臺南").order('created_at DESC').first
    @articleD = Article.where("status = 0 AND category LIKE ?","實踐者").order('created_at DESC').first
    @articleE = Article.where("status = 0 AND category LIKE ?","值得議題").order('created_at DESC').first
  end

  def open
    @article.status = 0
    flash[:success] = "關閉成功"
    @article.save
    redirect_to users_path
  end

  def close
    @article.status = 1
    flash[:success] = "開啟成功"
    @article.save
    redirect_to users_path
  end

  private
  	def find_article
      @article=Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title,:content,:summary,:category,:thumb,:status,:intro,:tag_list)
    end
end
