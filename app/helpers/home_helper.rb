module HomeHelper
  
  def carousel_markup 
    
    # read hash from json or yaml instead, with keys for: image, title, caption, link
    slides = %w(psych-market24 murnane-monument pdxA2004-002.692-cropped)
    
    html = <<-HTML
    <div id="home-carousel" class="carousel slide">
      <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
      </ol>
      <!-- Carousel items -->
      <div class="carousel-inner">
      HTML
      
      slide_html =[]
      
      slides.each_with_index do |slide, index|
        
        active_class = index == 0 ? "active " : ""
        
        a_slide = <<-slide
        <div class="#{active_class}item">
        	<a href="/stories/the-psychedelic-supermarket">
        	  <img alt="title" src="#{ENV['KYC_STATIC_ASSETS_URL']}#{slide}.jpg" />
        	</a>
    		  <div class="carousel-caption">
              <p>Psychedelic Market</p>
              <p>Teaser text!</p>
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
