# == Schema Information
#
# Table name: stories
#
#  id                      :integer          not null, primary key
#  title                   :string(255)
#  subtitle                :string(255)
#  summary                 :text
#  audio_filename          :string(255)
#  original_audio_filename :string(255)
#  image_name              :string(255)
#  image_credit            :string(255)
#  thumbnail_name          :string(255)
#  twitter_template        :string(255)
#  editorial_notes         :text
#  editing_priority        :integer          default(50)
#  audio_transcription     :text
#  display_order           :integer          default(50)
#  keywords                :string(255)
#  latitude                :float
#  longitude               :float
#  workflow_state_id       :integer          default(1)
#  collection_id           :integer          default(1)
#  theme_id                :integer
#  guest_id                :integer
#  media_type_id           :integer          default(1)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  image_credit_url        :text
#  image_copyright_notice  :string(255)
#  image_copyright_url     :text
#  image_copyright_details :text
#  slug                    :string(255)
#  photo_notes             :text
#  proofreader_id          :integer
#  more_info_url           :string(255)
#  more_info_title         :string(255)
#  more_info_description   :text
#  more_info_notes         :text
#  map_data                :text
#  map_data_type           :integer          default(0)
#

class Story < ActiveRecord::Base
  
  has_paper_trail
  
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates_presence_of :title, :slug
  
  # only generate slug once
  def should_generate_new_friendly_id?
    new_record?
  end
  
  # must have to use geocoder queries
  reverse_geocoded_by :latitude, :longitude
  
  # make sure coordinates are not nil:
  before_validation :generate_coordinates
  
  def generate_coordinates
    self.latitude ||= 0.0
    self.longitude ||= 0.0
  end
  
  def valid_coordinate?
    # we want to test whether the coordinate has been set from its default.
    # there's probably a better test than this.
    # it might even make sense to test that the coordinate is within geoscope, i.e.
    # a colleciton-specific bounding box.
    if (self.latitude.abs + self.longitude.abs) > 0.0
      return true
    else
      return false
    end
  end
  
  belongs_to :collection
  belongs_to :theme
  belongs_to :guest
  belongs_to :media_type
  belongs_to :workflow_state
  
  belongs_to :proofreader, :class_name => AdminUser
  
  # workflow: proposed, draft, deferred, incomplete, edited, published, testing
  scope :proposed, where(:workflow_state_id => 1)
  scope :draft, where(:workflow_state_id => 2)
  scope :deferred, where(:workflow_state_id => 3)
  scope :incomplete, where(:workflow_state_id => 4)
  scope :edited, where(:workflow_state_id => 5)
  scope :published, where(:workflow_state_id => 6)
  scope :testing, where(:workflow_state_id => 7)
  
  attr_accessible :audio_filename, :audio_transcription, :display_order, :editing_priority, :editorial_notes, :image_credit, :image_name, :keywords, :latitude, :longitude, :original_audio_filename, :audio_filename, :subtitle, :summary, :thumbnail_name, :title, :twitter_template, :collection_id, :theme_id, :guest_id, :media_type_id, :workflow_state_id, :image_credit_url, :image_copyright_notice, :image_copyright_url, :image_copyright_details, :slug, :photo_notes, :proofreader_id, :more_info_url, :more_info_title, :more_info_description, :more_info_notes

end
