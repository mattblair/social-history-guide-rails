module ApplicationHelper

  def title(page_title)
    content_for :title, "#{page_title.to_s} - #{ENV['WEBSITE_NAME']}"
  end

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end
  
  # use fractions for longer distances, and round to the nearest 1/4 mile?
  def humanize_distance distance, metric
    
    # < half km, use meters. < 1/4 mile, use feet.
    conversion_threshold = metric ? 0.5 : 0.25
    
    if distance < conversion_threshold
      conversion_factor = metric ? 1000 : 5280
      converted_distance = distance*conversion_factor
      unit = metric ? "meters" : "feet"
      text = "#{converted_distance.round(0).to_s} #{unit}"
    else
      unit = metric ? "km" : "miles"
      text = "#{distance.to_s} #{unit}"
    end
    
    text
  end
  
end
