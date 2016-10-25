class SearchController < ApplicationController
  
  authorize_resource

  def index
    if params[:q] && params[:scope]
      respond_with(@result = Search.run(params))
    else
      flash[:notice] = "You must fill the search-field and choose the searching-path."
    end
  end
end