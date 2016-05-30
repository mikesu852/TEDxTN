class FilmsController < ApplicationController
  before_action :check_login,only: %i[new]
  before_action :find_film, only: %i[destroy edit update]
  def index
    if params[:keyword]
      @films = Film.search(params[:keyword],params[:category],params[:event]).order('year DESC')
    else
      @films = Film.all.order('year DESC')
    end
  end

  def new
    @film = Film.new
  end


  def edit
  end

  def update
    if @film.update(film_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def create
    @film= Film.new(film_params)
    if @film.save
      redirect_to films_path
    else
      render 'new'
    end
  end

  def destroy
    @film.destroy
    redirect_to films_path
  end

  private
  	def find_film
      @film=Film.find(params[:id])
    end

    def film_params
      params.require(:film).permit(:title,:year,:event,:summary,:url,:category)
    end
end
