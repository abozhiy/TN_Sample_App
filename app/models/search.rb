class Search < ApplicationRecord

  def self.run(params)
    available_scope = ['Question', 'Answer', 'Comment', 'User', 'All']
    if available_scope.include?(params[:scope])
      classes = []
      classes << params[:scope].constantize unless params[:scope] == 'All'
      ThinkingSphinx.search(ThinkingSphinx::Query.escape(params[:q]), classes: classes)
    else
      return []
    end
  end
end
