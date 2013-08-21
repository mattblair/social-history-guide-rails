# == Schema Information
#
# Table name: tidbits
#
#  id                      :integer          not null, primary key
#  title                   :string(255)
#  year                    :string(255)
#  publication_date        :datetime
#  twitter_template        :string(255)
#  latitude                :float
#  longitude               :float
#  editorial_notes         :text
#  image_name              :string(255)
#  image_caption           :string(255)
#  image_credit            :string(255)
#  body                    :text
#  audio_filename          :string(255)
#  source                  :string(255)
#  source_url              :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  workflow_state_id       :integer          default(1)
#  media_type_id           :integer          default(3)
#  collection_id           :integer          default(1)
#  theme_id                :integer
#  image_credit_url        :text
#  image_copyright_notice  :string(255)
#  image_copyright_url     :text
#  image_copyright_details :text
#  media_copyright_notice  :string(255)
#  media_copyright_url     :text
#  media_copyright_details :text
#  slug                    :string(255)
#  photo_notes             :text
#  proofreader_id          :integer
#  more_info_url           :string(255)
#  more_info_title         :string(255)
#  more_info_description   :text
#  more_info_notes         :text
#  map_data                :text
#  map_data_type           :integer          default(0)
#  location_valid          :boolean          default(FALSE)
#  keywords                :string(255)
#  image_usage_cleared     :boolean          default(FALSE)
#  image_status_id         :integer          default(1)
#

class Tidbit < ActiveRecord::Base
  
  has_paper_trail
  
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates_presence_of :title, :slug
  
  # only generate slug once
  def should_generate_new_friendly_id?
    new_record?
  end
  
  # make sure coordinates are not nil:
  before_validation :generate_coordinates
  before_validation :set_pub_date
  after_validation :persist_coordinate_validity
  
  def generate_coordinates
    self.latitude ||= 0.0
    self.longitude ||= 0.0
  end
  
  def valid_coordinate?
    # see comment in story model
    if (self.latitude.abs + self.longitude.abs) > 0.0
      return true
    else
      return false
    end
  end
  
  def set_pub_date
    self.publication_date ||= DateTime.now
  end
  
  def persist_coordinate_validity
    self.location_valid = self.valid_coordinate?
  end
  
  def to_geojson
    
    theme_title = self.theme.nil? ? "" : self.theme.title
    
    geojson = <<-JSON 
    {
  	    "type": "Feature",
  	    "properties": {
  	        "title": "#{self.title}",
  	        "theme": "#{theme_title}",
  	        "link": "/tidbits/#{self.slug}"
  	    },
  	    "geometry": {
  	        "type": "Point",
  	        "coordinates": [#{self.longitude}, #{self.latitude}]
  	    }
  	}
    JSON
    
    geojson
  end
  
  # must have to use geocoder queries
  reverse_geocoded_by :latitude, :longitude
  
  belongs_to :workflow_state
  belongs_to :media_type
  belongs_to :image_status
  
  belongs_to :collection
  belongs_to :theme
  
  delegate :state_name, :to => :workflow_state
  
  belongs_to :proofreader, :class_name => AdminUser
  
  # workflow: proposed, draft, deferred, incomplete, edited, published, testing
  scope :proposed, where(:workflow_state_id => 1)
  scope :draft, where(:workflow_state_id => 2)
  scope :deferred, where(:workflow_state_id => 3)
  scope :incomplete, where(:workflow_state_id => 4)
  scope :edited, where(:workflow_state_id => 5)
  scope :published, where(:workflow_state_id => 6)
  scope :testing, where(:workflow_state_id => 7)
  
  attr_accessible :audio_filename, :body, :editorial_notes, :image_caption, :image_credit, :image_name, :latitude, :longitude, :publication_date, :source, :source_url, :title, :twitter_template, :year, :audio_filename, :workflow_state_id, :media_type_id, :collection_id, :theme_id, :image_credit_url, :image_copyright_notice, :image_copyright_url, :image_copyright_details, :media_copyright_notice, :media_copyright_url, :media_copyright_details, :slug, :photo_notes, :proofreader_id, :more_info_url, :more_info_title, :more_info_description, :more_info_notes, :map_data, :map_data_type, :location_valid, :keywords, :image_usage_cleared, :image_status_id
end
