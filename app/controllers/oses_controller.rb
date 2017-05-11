class OsesController < ApplicationController

  def index
    @oses = Ose.all
  end

  def show
    @os = Ose.find(params[:id])
  end

  def new
    @os = Ose.new
  end

  def create
    @os = Ose.create(pool_params)

    @os.save
    redirect_to oses_path
  end

  def edit
    @os = Ose.find(params[:id])
  end

  def update
    @os = Ose.find(params[:id])

    @os.update(os_params)
    redirect_to oses_path
  end

  def destroy
    @os = Ose.find(params[:id]).update(is_enabled: 0)
  end

  private
    def os_params
      params.require(:ose).permit(:name, :description, :is_enabled)
    end

end
