module ApplicationHelper

  def full_title(page_title)
    base_title = "TN Sample App"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def collection_cache_key_for(model)
    klass = model.to_s.capitalize.constantize
    count = klass.count
    max_updated_at = klass.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "#{model.to_s.pluralize}/collection-#{count}-#{max_updated_at}"
  end
end
