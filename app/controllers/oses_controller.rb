class OsesController < ApplicationController

  def index
    @oses = Ose.all
    @newOS = Ose.new
  end

  def show
    @os = Ose.find(params[:id])
  end

  def new
    @os = Ose.new
  end

  def create
    @os = Ose.new(os_params)
    @os.update(:is_enabled => 1)
    @os.save
    redirect_to oses_path
  end

  def edit
    @os = Ose.find(params[:id])
    @oses = Ose.all
  end

  def update
    @os = Ose.find(params[:id])

    @os.update(os_params)
    redirect_to oses_path
  end

  def destroy
    @os = Ose.find(params[:id])
    @os.update(:is_enabled => @os.is_enabled == 1 ? 0 : 1 )

    redirect_to oses_path
  end

  def changeStatus
    @os = Ose.find(params[:id])
    @os.update(:is_enabled => @os.is_enabled == 1 ? 0 : 1)

    redirect_to oses_path
  end

  private
    def os_params
      params.require(:ose).permit(:name, :description, :is_enabled)
    end

end
