atom_feed do |feed|
  title = "#{current_group.current_group.display_name_i} - #{t("@doctype").capitalize} #{t("feeds.feed")}"

  tags = params[:tags]
  if tags && !tags.empty?
    title += " tags: #{tags.kind_of?(String) ? tags : tags.join(", ")}"
  end

  #if @langs_conds
  #  if @langs_conds.kind_of?(Array)
  #    title += " languages: #{@langs_conds.join(", ")}"
  #  else
  #    title += " languages: #{@langs_conds}"
  #  end
  #end

  feed.title(title)
  unless @items.empty?
    feed.updated(@items.first.updated_at)
  end

  for item in @items
    next if item.nil? || item.updated_at.blank?
    feed.entry(item, :url => item_url(item)) do |entry|
      entry.title(item.title)
      entry.content(markdown(item.body), :type => 'html')
      entry.author do |author|
        author.name(item.user.display_name)
      end
    end
  end
end
