class SupportStuffsController < ApplicationController

  def index
    @cfg = SupportStuff.all
  end

  def new
    @cfg = SupportStuff.find(params[:id])
  end

  def create
    @newCFG = SupportStuff.new(params_cfg)
    @newCFG.save
  end

  def edit
    @cfg = SupportStuff.find(params[:id])
  end

  def update

  end

  def destroy

  end

  private
    def params_cfg
      params.require(:support_stuff).permit(:name, :value, :description)
    end

end
