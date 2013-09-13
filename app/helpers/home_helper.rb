module HomeHelper
  
  def carousel_markup 
    
    require 'json'
    
    # read hash from json or yaml instead
    slide_data = <<-DATA
    [
      {
        "image": "A2004-002.704",
        "title": "Floods and Parks",
        "caption": "Lorem ipsum dolor sit amet, consectetur adipisicing elit...",
        "link": "/stories/dkc-mccall-waterfront-park"
      },
      {
        "image": "duniway-slide",
        "title": "Abigail Scott Duniway",
        "caption": "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        "link": "/stories/abigail-scott-duniway"
      },
      {
        "image": "murnane-monument",
        "title": "A Missing Memorial",
        "caption": "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ...",
        "link": "/stories/francis-murnane-memorial"
      },
      {
        "image": "pdxA2004-002.692-cropped",
        "title": "On the Waterfront",
        "caption": "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
        "link": "/stories/crimping"
      },
      {
        "image": "psych-market24",
        "title": "The Psychedelic Market",
        "caption": "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor...",
        "link": "/stories/the-psychedelic-supermarket"
      }
    ] 
    DATA
    
    slides = JSON.parse(slide_data)
    
    html = <<-HTML
    <div id="home-carousel" class="carousel slide span8">
      <ol class="carousel-indicators">
    HTML
    
    slides.each_with_index do |slide, index|
        
        active_class = index == 0 ? " class=\"active\"" : ""
        
        html << %(<li data-target="#myCarousel" data-slide-to="#{index}"#{active_class}"></li>)
    end
            
    indicator_close = <<-close  
      </ol>
      <!-- Carousel items -->
      <div class="carousel-inner">
    close
      
    html << indicator_close  
      
    slides.each_with_index do |slide, index|
      
      active_class = index == 0 ? "active " : ""
      
      a_slide = <<-slide
      <div class="#{active_class}item">
      	<a href="#{slide['link']}">
      	  <img alt="title" src="#{ENV['KYC_STATIC_PHOTOS_URL']}#{slide['image']}.jpg" />
      	</a>
  		  <div class="carousel-caption">
            <h3>#{slide['title']}</h3>
            <p>#{slide['caption']}</p>
  		  </div>
      </div>
      slide
      
      html << a_slide
      
    end
        
    slide_suffix = <<-SUFFIX    
      </div>
      <!-- Carousel nav -->
      <a class="carousel-control left" href="#myCarousel" data-slide="prev">&lsaquo;</a>
      <a class="carousel-control right" href="#myCarousel" data-slide="next">&rsaquo;</a>
    </div>
    SUFFIX
    
    html << slide_suffix
    
    html.html_safe
  end
  
end
