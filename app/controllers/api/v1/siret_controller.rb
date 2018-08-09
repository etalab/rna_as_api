class API::V1::SiretController < ApplicationController
  def show
    result = Association.find_by(siret: siret_params[:siret])

    if result.nil?
      render json: { message: 'no results found' }, status: 404
    else
      render json: { association: result }, status: 200
    end
  end

  private

  def siret_params
    params.permit(:siret)
  end
end
