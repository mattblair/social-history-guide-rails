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
#

require 'spec_helper'

describe Tidbit do
  pending "add some examples to (or delete) #{__FILE__}"
end
