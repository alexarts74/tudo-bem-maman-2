class ClothesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @clothes = Clothe.all
  end

  def new
    @clothes = Clothe.new
  end

  def show
    @clothes = Clothe.find(params[:id])
  end

  def create
    @clothes = Clothe.new(clothes_params)
    if @clothes.save
      redirect_to clothes_path
    else
      render :new
    end
  end

  def edit
    @clothes = Clothe.find(params[:id])
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
    @clothes = Clothe.find(params[:id])
    @clothes.destroy
    redirect_to clothes_path
  end

  private

  def clothes_params
    params.require(:clothes).permit(:name, :price, :image)
  end
end
