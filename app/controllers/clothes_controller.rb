class ClothesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home index show]

  def home
  end

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
    @clothe = Clothe.new(clothe_params)
    @clothe.user = current_user
    if @clothe.save
      redirect_to clothes_path
    else
      render :new
    end
  end

  def edit
    @clothe = Clothe.find(params[:id])
  end

  def update
    @clothe = Clothe.find(params[:id])
    if @clothe.update(clothe_params)
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

  def my_dashboard
    #mettre les infos liés au paiement pour Louis
  end

  private

  def clothe_params
    params.require(:clothe).permit(:name, :price, :image, :description, :size, :category)
  end
end
