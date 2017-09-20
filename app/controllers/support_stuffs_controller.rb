class SupportStuffsController < ApplicationController

  def index
    @cfg = SupportStuff.all
  end

  def new
    @cfg = SupportStuff.find(params[:id])
  end

  def create
    @newCFG = SupportStuff.new(cfg_params)
    @newCFG.save
  end

  def edit
    @cfg = SupportStuff.find(params[:id])
  end

  def update
    @cfg = SupportStuff.find(params[:id])
    @cfg.update(cfg_params)

    redirect_to support_stuffs_path
  end

  def destroy

  end

  private
    def cfg_params
      params.require(:support_stuff).permit(:name, :value, :description)
    end

end
