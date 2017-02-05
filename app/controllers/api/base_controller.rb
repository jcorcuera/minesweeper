class Api::BaseController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def record_not_found
    render json: { error: 'Resource does not exist' }, status: :not_found
  end

end
