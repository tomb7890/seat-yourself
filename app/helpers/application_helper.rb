module ApplicationHelper

  def prettyprint(x)
    formatted_date = x.strftime('%A, %b %d %Y  at %H:%M:%S %Z %Y') 
    formatted_date
  end


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
