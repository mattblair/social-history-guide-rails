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
    html = "<img alt=\"Story Thumbnail\" class=\"theme-story-thumbnail\" src=\"#{ENV['KYC_STATIC_PHOTOS_URL']}#{thumb_name}.jpg\" />"
    return html.html_safe
  end

  def story_image_markup image_field
    
    html = ''
    
    # what will the handling be for stories that have no image or media content?
    if image_field.empty?
      html = "<img alt=\"Placeholder\" class=\"story-image\" src=\"#{ENV['KYC_STATIC_PHOTOS_URL']}kyc-placeholder.jpg\" />"
    else 
      
      # test case: "murnane-monument ilwu-harry-bridges"
      images = image_field.split(" ")
      
      if images.count > 1 # if multiple, show carousel code
        
        # temp, until carousel implemented show second image:
        html = "<img alt=\"Story Image\" class=\"story-image\" src=\"#{ENV['KYC_STATIC_PHOTOS_URL']}#{images[1]}.jpg\" />"
        
        # prefix slideshow stuff
        
        images.each do |image|
          # output that image
        end
        
        #suffix of slideshow stuff
        
      else # just show the image
        
        html = "<img alt=\"Story Image\" class=\"story-image\" src=\"#{ENV['KYC_STATIC_PHOTOS_URL']}#{@story.image_name}.jpg\" />"
      end
    end
    return html.html_safe
  end
  
  def story_image_credit_markup story
    
    if story.image_credit_url.empty?
      credit = story.image_credit
    else
      credit = %(<a href="#{story.image_credit_url}">#{story.image_credit}</a>)
    end
    
    # Temporary. Stories shouldn't be published without media copyright details.
    notice = story.image_copyright_notice.empty? ? "COPYRIGHT TBD" : story.image_copyright_notice
    
    if story.image_copyright_url.empty?
      copyright = %(\(#{notice}\))
    else
      copyright = %(\(<a href="#{story.image_copyright_url}">#{notice}</a>\))
    end
    
    html = %(<p class="image-credit">Image: #{credit} #{copyright}</p>)
    
    return html.html_safe
  end
  
  def story_dynamic_map geojson_chunk
    # returns the markup for a dynamic map with one or more labelled points
    return ''
  end
  
  def story_nearby_list nearby_array
    
    html = <<-HTML 
      <table class="table table-striped">
        <caption>Nearby Stories</caption>
        <tbody>
    HTML
    
    nearby_array.each do |story|
        row_html = <<-ROW 
          <tr>
            <td>#{link_to story.title, story}</td>
            <td class="nearby-theme">#{story.theme.title}</td>
            <td class="nearby-distance">#{story.distance.round(2)} miles</td>
          </tr>
        ROW
        
        html << row_html
    end
    
    html << %(</tbody>)
    html << %(</table>)
    
    html.html_safe
  end
  
  
  def story_more_info_markup story
    
    return '' if (story.more_info_description.empty?)
    
    html = <<-HTML
    <div id="more-info-section">
    	<h2>More Info:</h2>
    	<p class="more-info-title"><a href="#{story.more_info_url}">#{story.more_info_title}</a></p>
    	<p class="more-info-description">#{story.more_info_description}</p>
    </div>
    HTML
    
    html.html_safe
  end
  
end
