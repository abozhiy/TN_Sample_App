class Search < ApplicationRecord

  def self.run(params)
    classes = []
    scope = params[:scope]
    query = params[:q]
    classes << scope.constantize unless scope == 'All'
    ThinkingSphinx.search query, classes: classes
  end
end
