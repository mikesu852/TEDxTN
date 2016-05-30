class PicturesController < ApplicationController
  before_action :check_login,only: %i[new]
  before_action :find_picture, only: %i[show destroy]

  def index
    @picture = Picture.all
  end

  def new
    @picture = Picture.new
  end


  def create
    @picture= Picture.new(picture_params)
    if @picture.save
      redirect_to @picture
    else
      render 'new'
    end
  end

  def show
  end

  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private
  	def find_picture
      @picture=Picture.find(params[:id])
    end

    def picture_params
      params.require(:picture).permit(:image,:name)
    end
end
