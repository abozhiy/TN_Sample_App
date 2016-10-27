class Search < ApplicationRecord

  SCOPES = ['Question', 'Answer', 'Comment', 'User', 'All']

  def self.run(params)
    return [] unless SCOPES.include?(params[:scope])
    classes = []
    classes << params[:scope].constantize unless params[:scope] == 'All'
    ThinkingSphinx.search(ThinkingSphinx::Query.escape(params[:q]), classes: classes)
  end
end
