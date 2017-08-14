class AutozillaKeyConfigsController < ApplicationController

  def new
    @cv = ClonezillVersion.find(params[:id])
  end

  def create
    @cv = ClonezillaVersion.find(params[:clonezilla_versions_id])
    @azk = AutozillaKeyConfig.find(params[:id])
  end

  def edit

  end

  def update

  end

end
