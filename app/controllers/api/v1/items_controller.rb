class Api::V1::ItemsController < ApplicationController
  respond_to :json

    def index
      respond_with Item.all
    end

    def show
      respond_with Item.find_by(id: params[:id])
    end

    def find
      if params["name"] || params["description"]
        respond_with Item.find_by("#{params.first.first} ILIKE ?", params.first.last)
      else
        respond_with Item.find_by("#{params.first.first}": params.first.last)
      end
    end
end
