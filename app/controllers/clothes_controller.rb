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
      render :new, status: :unprocessable_entity
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
    @clothe = Clothe.all
  end

  def my_cart
    @clothes = Clothe.find(session[:cart])
  end

  def add_to_cart
    id = params[:id].to_i
    session[:cart] << id unless session[:cart].include?(id)
    redirect_to my_cart_path
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to clothes_path
  end

  private

  def clothe_params
    params.require(:clothe).permit(:name, :price, :image, :description, :size, :category)
  end
end
