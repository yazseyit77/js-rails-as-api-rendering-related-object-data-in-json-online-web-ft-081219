class SightingsController < ApplicationController

    def index
        sightings = Sighting.all
        render json: sightings, include: [:bird, :location]
        # render json: sightings.to_json(include: [:bird, :location])
    end

    def show
        sighting = Sighting.find_by(id: params[:id])
        # render json: { id: sighting.id, bird: sighting.bird, location: sighting.location }

        # alternative way of showing what model you want to nest:
        # render json: sighting, include: [:bird, :location]
        # render json: sighting.to_json(include: [:bird, :location])

        # if we wanted to remove the :updated_at and :created_at attribute from Sighting when rendered:
        # render json: sighting, include: [:bird, :location], except: [:updated_at, :created_at]

        # more nested filtering to show necessary data:
        render json: sighting.to_json(:include => {
            :bird => {:only => [:name, :species]},
            :location => {:only => [:latitude, :longitude]}
          }, :except => [:updated_at])

        # adding some error handling:
        # if sighting
        #     render json: sighting.to_json(include: [:bird, :location])
        # else
        #     render json: { message: 'No sighting found with that id' }
        # end
    end
end
