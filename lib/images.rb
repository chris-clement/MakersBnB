class Images
  URL = {}
  def self.save_url(space_name, url)
    URL[space_name] = url
  end

  def self.url_by_space(space_name)
    URL[space_name]
  end
end