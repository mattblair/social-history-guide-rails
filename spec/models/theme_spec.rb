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
#  map_data                :text
#  map_data_type           :integer
#  display_in_story_list   :boolean          default(TRUE)
#  display_in_tidbit_list  :boolean          default(TRUE)
#

require 'spec_helper'

describe Theme do
  pending "add some examples to (or delete) #{__FILE__}"
end
