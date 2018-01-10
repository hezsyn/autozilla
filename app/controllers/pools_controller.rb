class PoolsController < ApplicationController

  def index
    @pools = Pool.all
    @newPool = Pool.new
  end

  def new
    @pool  = Pool.new
  end

  def create
    @pool = Pool.create(pool_params)

    redirect_to pools_path
  end

  def edit
    @pool = Pool.find(params[:id])
    @pools = Pool.all
  end

  def update
    @pool = Pool.find(params[:id])

    @pool.update(pool_params)
    redirect_to pools_path
  end

  def destroy
    @pool = Pool.find(params[:id])
      if @pool.is_enabled == 0 || @pool.is_enabled == nil
        @pool.update(:is_enabled => 1)
      else
        @pool.update(:is_enabled => 0)
      end
    redirect_to pools_path
  end

  private
    def pool_params
      params.require(:pool).permit(:name, :description, :is_enabled)
    end

end
