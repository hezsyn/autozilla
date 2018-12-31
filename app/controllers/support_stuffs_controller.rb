class SupportStuffsController < ApplicationController

  def index
    @root = SupportStuff.find_by_name("rootDir")

    @czLocals = SupportStuff.find_by_name("azkLocales")

    @ddl = SupportStuff.where("name LIKE 'ddl%'").order(:created_at)
    @dup = SupportStuff.where("name LIKE 'dup%'").order(:created_at)
  end

  def update
    @cfg = SupportStuff.find(params[:id])
    @cfg.update(cfg_params)

    redirect_to support_stuffs_path, notice: "Update of #{@cfg.name} has been completed"
  end

  private
    def cfg_params
      params.require(:support_stuff).permit(:name, :value, :description)
    end

end
