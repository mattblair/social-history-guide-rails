# == Schema Information
#
# Table name: themes
#
#  id                      :integer          not null, primary key
#  title                   :string(255)
#  subtitle                :string(255)
#  summary                 :text
#  image_name              :string(255)
#  image_credit            :string(255)
#  twitter_template        :string(255)
#  editorial_notes         :text
#  latitude                :float
#  longitude               :float
#  display_order           :integer
#  keywords                :string(255)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  workflow_state_id       :integer          default(1)
#  image_credit_url        :text
#  image_copyright_notice  :string(255)
#  image_copyright_url     :text
#  image_copyright_details :text
#  slug                    :string(255)
#  proofreader_id          :integer
#

class Theme < ActiveRecord::Base
  
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates_presence_of :title, :slug
  
  # only generate slug once
  def should_generate_new_friendly_id?
    new_record?
  end
  
  has_many :tidbits
  has_many :stories
  
  belongs_to :workflow_state
  
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
  
  attr_accessible :display_order, :editorial_notes, :image_credit, :image_name, :keywords, :latitude, :longitude, :subtitle, :summary, :title, :twitter_template, :workflow_state_id, :image_credit_url, :image_copyright_notice, :image_copyright_url, :image_copyright_details, :slug, :proofreader_id
end
