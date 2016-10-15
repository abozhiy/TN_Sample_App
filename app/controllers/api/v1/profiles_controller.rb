class Api::V1::ProfilesController < Api::V1::BaseController
  before_action :authorize, only: [:me, :index]

  # authorize_resource
  
  def me
    respond_with current_resource_owner
  end

  def index
    @users = User.where.not(id: current_resource_owner)
    respond_with @users
  end

  private

    def authorize
      authorize!(params[:action].to_sym, @profile)
    end
end
