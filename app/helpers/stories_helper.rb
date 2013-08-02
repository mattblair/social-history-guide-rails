module StoriesHelper
  
  # to provide more control than the standard audio_tag helper method
  def kyc_audio_tag audio_filename
    return '' if (audio_filename.empty?)
    host_path_name = ENV["KYC_STATIC_AUDIO_URL"] + audio_filename
    html = <<-HTML
    <audio controls="controls" id="story_audio_player">
    	<source src="#{host_path_name}.mp3" />
    	<source src="#{host_path_name}.ogg" />
    	  <!-- some other kind of failure-handling, like a flash fallback? -->
    	 Needs different format 
    </audio>
    HTML
    html.html_safe
  end

  def story_thumbnail_tag image_field
    if image_field.empty?
      # should there be a thumbnail-sized version? Or will we omit?
      thumb_name = "kyc-placeholder"
    else
      images = image_field.split(" ")
      
      # always use the first one
      thumb_name = images[0] + "-tn"
    end
    html = "<img alt=\"Story Thumbnail\" class=\"theme-story-thumbnail\" src=\"#{ENV['KYC_STATIC_ASSETS_URL']}#{thumb_name}.jpg\" />"
    return html.html_safe
  end

  def story_image_markup image_field
    
    html = ''
    
    if image_field.empty?
      html = "<img alt=\"Placeholder\" class=\"story_image\" src=\"#{ENV['KYC_STATIC_ASSETS_URL']}kyc-placeholder.jpg\" />"
    else 
      
      # test case: "murnane-monument ilwu-harry-bridges"
      images = image_field.split(" ")
      
      if images.count > 1 # if multiple, show carousel code
        
        # temp, until carousel implemented show second image:
        html = "<img alt=\"Story Image\" class=\"story_image\" src=\"#{ENV['KYC_STATIC_ASSETS_URL']}#{images[1]}.jpg\" />"
        
        # prefix slideshow stuff
        
        images.each do |image|
          # output that image
        end
        
        #suffix of slideshow stuff
        
      else # just show the image
        
        html = "<img alt=\"Story Image\" class=\"story_image\" src=\"#{ENV['KYC_STATIC_ASSETS_URL']}#{@story.image_name}.jpg\" />"
      end
    end
    return html.html_safe
  end
  
  def story_image_credit_markup story
    
    # add a div instead
    html = "<p class=\"image-credit\"><em>Image credit:</em> #{story.image_credit}</p>"
    
    # image credit, with url
    # image copyright, with url
    
    return html.html_safe
  end
  
  def story_dynamic_map geojson_chunk
    # returns the markup for a dynamic map with one or more labelled points
    return ''
  end
  
end
