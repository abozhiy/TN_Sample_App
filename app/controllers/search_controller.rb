class SearchController < ApplicationController
  
  authorize_resource

  def index
    respond_with(@result = Search.run(params))
  end
end