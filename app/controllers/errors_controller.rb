class ErrorsController < ApplicationController
  skip_before_action :authenticate_user!
  def not_found
    render status: :not_found   # 404
  end

  def internal_server_error
    render status: :internal_server_error  # 500
  end

  def unprocessable_entity
    render status: :unprocessable_entity  # 422
  end
end
