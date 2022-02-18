module ApplicationHelper


  def smart_add_url_protocol(url)
    if url 
      if url[/\Ahttp:\/\//] || url[/\Ahttps:\/\//]
        url 
      else
        "http://#{url}"
      end
    end      
  end

  
  
end
