class ClothesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @clothes = Clothe.all
  end

  def new
    @clothe = Clothe.new
  end

  def show
    @clothe = Clothe.find(params[:id])
  end

  def create
    @clothe = Clothe.new(clothes_params)
    if @clothes.save
      redirect_to clothes_path
    else
      render :new
    end
  end

  def edit
    @clothe = Clothe.find(params[:id])
  end

  def update
    @clothes = Clothe.find(params[:id])
    if @clothes.update(clothes_params)
      redirect_to clothes_path
    else
      render :edit
    end
  end

  def destroy
    @clothe = Clothe.find(params[:id])
    @clothe.destroy
    redirect_to clothes_path
  end

  private

  def clothes_params
    params.require(:clothe).permit(:name, :price, :image, :description, :size, :category)
  end
end
