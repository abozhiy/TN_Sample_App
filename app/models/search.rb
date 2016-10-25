class Search < ApplicationRecord

  def self.run(params)
    classes = []
    scope = params[:scope]
    query = params[:q]
    classes << scope.constantize unless scope == 'All'
    ThinkingSphinx.search(ThinkingSphinx::Query.escape(query), classes: classes)
  end
end
