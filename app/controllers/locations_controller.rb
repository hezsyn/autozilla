class LocationsController < ApplicationController

    def index
        @locations = Location.all
        @newLocation = Location.new
    end

    def create
        @location = Location.create(params_loc)
        @location.enabled = 1
        if @location.save
            flash[:notice] = "New Location created"
        else
            flash[:alert] = "Failed to create Location"
        end
        redirect_to  locations_path
    end

    def update
        @location = Location.find(params[:id])
        if @location.update(params_loc)
            flash[:notice] = "Location #{@location.name} updated"
        else
            flash[:alert] = "Failed to update #{@location.name} location"
        end

        redirect_to locations_path
    end

    def changeStatus
        @location = Location.find(params[:id])

      if @location.enabled == 0
        @location.update(:enabled => 1)
        flash[:notice] = "#{@location.name} has been enabled"
      else
        @location.update(:enabled => 0)
        flash[:alert] = "#{@location.name} has been disabled"
      end
      
      redirect_to locations_path
    end

    def changeDefault
        location = Location.find(params[:id])
        default = Location.find_by_default(1)

        default.update(default: 0)
        location.update(default: 1)

        redirect_to locations_path, notice: "Default changed to #{location.name}"
    end

    private
        def params_loc
            params.require(:location).permit(:name, :location, :description)
        end

end
