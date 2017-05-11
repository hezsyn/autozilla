class PoolsController < ApplicationController

  def index
    @pools = Pool.all
  end

  def show
    @pool = Pool.find(params[:id])
  end

  def new
    @pool = Pool.new
  end

  def create
    @pool = Pool.create(pool_params)

    @pool.save
    redirect_to pools_path
  end

  def edit
    @pool = Pool.find(params[:id])
  end

  def update
    @pool = Pool.find(params[:id])

    @pool.update(pool_params)
    redirect_to pools_path
  end

  def destroy
    @pool = Pool.find(params[:id]).update(is_enabled: 0)
    redirect_to pools_path
  end

  def enable
    @pool = Pool.find(params[:id]).update(is_enabled: 1)
    redirect_to pools_path
  end

  private
    def pool_params
      params.require(:pool).permit(:name, :description, :is_enabled)
    end

end
