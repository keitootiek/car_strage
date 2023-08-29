class CarsController < ApplicationController

  before_action :log_out, only:[:index, :new]
  
  def index
    @cars = Car.all
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      redirect_to  cars_path
    else
      render :new
    end
  end

  def show
    @car = Car.find(params[:id])
  end

  private
  def car_params
    params.require(:car).permit(:name, :maker_id, :model_year, :mileage, :prefecture_id, :price, :car_code, {images: []}).merge(user_id: current_user.id)
  end
  
  def log_out #ログアウト状態ではログイン画面へ遷移
    unless user_signed_in?
      redirect_to user_session_path
    end
  end

end
