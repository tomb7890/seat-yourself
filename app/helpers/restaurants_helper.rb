module RestaurantsHelper


  def fetch_list_of_restaurants(params)

        if params[:search].present? 
      Restaurant.near(params[:search], 5, units: :km )
    elsif params[:longitude] && params[:latitude]
      Restaurant.near([params[:latitude], params[:longitude]], 5, units: :km)      
    elsif params[:category].present?
      Category.find_by(name: params[:category]).restaurants.order('restaurants.name')
    else
      Restaurant.all.order('restaurants.name')
    end

  end

  def url_helper(url)

    if url.blank?
      nil
    
    elsif url  =~ /http(s?):\/\/.*/
      url
    else
      "http://#{url}"
    end
  end


end
