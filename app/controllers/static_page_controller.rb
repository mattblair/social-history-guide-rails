class StaticPageController < ApplicationController
  def about
  end

  def nearby
    
    # if location is available, use that to fetch data to map here...
    
    @tidbits = Tidbit.where('location_valid' => true)
    
    features = []
    
    @tidbits.each do |tidbit| 
      features << tidbit.to_geojson.html_safe
    end
    
    @geojson = "[#{features.join(",")}]".html_safe
    
    # calculate a centroid here, too?
    
  end

  def contact
  end

  def credits
  end

  def suggestions
  end

  def donate
  end
end
