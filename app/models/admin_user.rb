# == Schema Information
#
# Table name: admin_users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  human_name             :string(255)
#  username               :string(255)
#

class AdminUser < ActiveRecord::Base
  
  rolify
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :proofread_stories, :class_name => Story, :foreign_key => :proofreader_id
  has_many :proofread_tidbits, :class_name => Tidbit, :foreign_key => :proofreader_id
  has_many :proofread_themes, :class_name => Theme, :foreign_key => :proofreader_id
  has_many :proofread_guests, :class_name => Guest, :foreign_key => :proofreader_id

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :human_name, :username
  
  def to_s
    email # change to name once that's been added
  end
  
end
