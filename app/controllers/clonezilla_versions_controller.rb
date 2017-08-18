class ClonezillaVersionsController < ApplicationController

  def index
    @czvs = ClonezillaVersion.all.order('name DESC')
    @newCV = ClonezillaVersion.new
  end

  def show
    @cv = ClonezillaVersion.find(params[:id])
  end

  def new
    @cv = ClonezillaVersion.new
  end

  def create
    @cv = ClonezillaVersion.create(czv_params)
    @cv.is_enabled = 1
    @cv.save

    redirect_to clonezilla_versions_path
  end

  def edit
    @czs = ClonezillaVersion.all.order(name: :desc)
    @cz = ClonezillaVersion.find(params[:id])
    @czParam = AutozillaKeyConfig.all
    @azk = AutozillaKeyConfig.all
  end

  def update
    @cv = ClonezillaVersion.find(params[:id])
    @cv.update(czv_params)
  end

  def destroy
    @cv = ClonezillaVersion.find(params[:id])
      if @cv.is_enabled == 0
        @cv.update(:is_enabled => 1)
      else
        @cv.update(:is_enabled => 0)
      end

    redirect_to clonezilla_versions_path
  end

  private
    def czv_params
      params.require(:clonezilla_version).permit(:name, :description, :is_enabled)
    end

end
