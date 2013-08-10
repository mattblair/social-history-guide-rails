class StaticPageController < ApplicationController
  def about
  end

  def nearby
    
    # if location is available, use that to fetch data to map here...
    
    @tidbits = Tidbit.where('location_valid' => true)
    
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
