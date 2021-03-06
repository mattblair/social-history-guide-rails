module StoriesHelper
  
  # to provide more control than the standard audio_tag helper method
  def kyc_audio_tag audio_filename
    return '' if (audio_filename.empty?)
    host_path_name = ENV["KYC_STATIC_AUDIO_URL"] + audio_filename
    ogg_path_name = ENV["KYC_STATIC_OGG_URL"] + audio_filename
    html = <<-HTML
    <audio controls="controls" id="story_audio_player">
    	<source src="#{host_path_name}.mp3" />
    	<source src="#{ogg_path_name}.ogg" />
    	  <!-- some other kind of failure-handling, like a flash fallback? -->
    	 Needs different format 
    </audio>
    HTML
    html.html_safe
  end

  def story_thumbnail_tag image_field
    if image_field.empty?
      # should there be a thumbnail-sized version? Or will we omit?
      thumb_name = "pshg-placeholder" # was "kyc-placeholder"
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
  
  # content can be a story or a tidbit
  # for_map is a boolean that determines prefix, class
  def media_credit_markup content, for_map
    
    if content.image_credit_url.empty?
      credit = content.image_credit
    else
      credit = %(<a href="#{content.image_credit_url}">#{content.image_credit}</a>)
    end
    
    # Temporary. Stories shouldn't be published without media copyright details.
    notice = content.image_copyright_notice.empty? ? "Used by Permission" : content.image_copyright_notice
    
    if content.image_copyright_url.empty?
      copyright = %(\(#{notice}\))
    else
      copyright = %(\(<a href="#{content.image_copyright_url}">#{notice}</a>\))
    end
    
    # define in stories.css.scss if a distinction needs to be made
    css_class = for_map ? "media-credit map-credit" : "media-credit"
    credit_prefix = for_map ? "Map Data" : "Image"
    #credit_id = for_map ? " id=\"map-caption\"" : ""
    html = %(<p class="#{css_class}">#{credit_prefix}: #{credit} #{copyright}</p>)
    
    return html.html_safe
  end
  
  # http://support.twitter.com/articles/231474-adding-the-tweet-button-to-your-website
  # https://twitter.com/about/resources/buttons#tweet
  def pshg_twitter_button topic 
    
    # truncate topic here? or expect caller to do it?
    
    html = ''
    html << %(<a href="https://twitter.com/share" class="twitter-share-button" data-text="I'm learning about #{topic} in Portland" data-hashtags="#{ENV["DEFAULT_HASH_TAG"]}">Tweet</a>
    <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>)
    
    html.html_safe
  end
  
  # based on:
  # https://developers.facebook.com/docs/reference/plugins/like/
  def pshg_facebook_js_code 
    
    html = ''
    html << %(
      <div id="fb-root"></div>
      <script>(function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
        fjs.parentNode.insertBefore(js, fjs);
      }(document, 'script', 'facebook-jssdk'));</script>
    )
    
    html.html_safe
  end
  
  def pshg_facebook_like_button link_to_like 
    
    html = ''
    html << %(<div class="fb-like" data-href="#{link_to_like}" data-width="80" data-layout="button_count" data-show-faces="true" data-send="false"></div>)
    
    html.html_safe
  end
  
  # probably specific to stories, might be used for themes
  # in initial version, this may be the only presentaiton of guest info
  # since we don't have enough details
  # first argument: the Guest object
  # second argument: boolean to show link to guest page
  def guest_stub_markup guest, show_link
    
    html = ''
    html << %(<div id="story-guest-section">)
    
    if !guest.image_name.nil? and guest.image_name.length > 0
      html << %(<img alt="Guest thumbnail" class="guest_thumbnail" src="#{ENV['KYC_STATIC_PHOTOS_URL']}#{guest.image_name}.jpg" />)
    end
    	
    html << %(<h4 id="guest-thumbnail-title">As Told By...</h4>)
    
    if show_link
      html << %(<p>#{link_to(guest.name, guest)}</p>)
    else
      html << %(<p><strong>#{guest.name}</strong></p>)
    end
    	
    html << %(<p>#{guest.title}</p>)
    html << %(<p>#{guest.organization}</p>)
    if !guest.guest_url.nil? and guest.guest_url.length > 0 
      html << %(<p>Website: <a href="#{guest.guest_url}">#{guest.guest_url_text}</a></p>)
    end
    html << %(<p>#{guest.bio}</p>)
    html << %(</div>)
    
    html.html_safe
  end
  
  def story_dynamic_map geojson_chunk
    # returns the markup for a dynamic map with one or more labelled points
    return ''
  end
  
  def story_nearby_list nearby_array
    
    if nearby_array.count > 0
      
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
              <td class="nearby-distance">#{humanize_distance(story.distance.round(2), false)}</td>
            </tr>
          ROW
        
          html << row_html
      end
    
      html << %(</tbody>)
      html << %(</table>)
    
      html.html_safe
    else
      nil
    end
  end
  
  
  def story_more_info_markup story
    
    return '' if (story.more_info_description.empty?)
    
    html = <<-HTML
    <div id="more-info-section">
    	<p class="more-info-header">More Information:</p>
    	<h4 class="more-info-title">#{story.more_info_title}</h4>
    	<p class="more-info-description">#{story.more_info_description} <a href="#{story.more_info_url}" class="more-info-link">Read More</a></p>
    </div>
    HTML
    
    html.html_safe
  end
  
end
