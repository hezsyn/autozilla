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

    if @pool.save
      redirect_to @pool
    else
      render 'new'
    end
  end

  def edit
    @pool = Pool.find(params[:id])
  end

  def update
    @pool = Pool.find(params[:id])

    @pool.update(pool_params)
  end

  def destroy
    @pool = Pool.find(params[:id]).update(is_enabled: 0)
  end

  private
    def pool_params
      params.requrie(:pool).(:name, :is_enabled)
    end

end
