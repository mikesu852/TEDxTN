module FilmsHelper
  def embed(url)
    youtube_id = url.split("=").last
    content_tag(:iframe, nil, :src => "//www.youtube.com/embed/#{youtube_id}" , :class => "film" , :allowfullscreen => true)
  end
end
