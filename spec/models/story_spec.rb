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
#

require 'spec_helper'

describe Story do
  pending "add some examples to (or delete) #{__FILE__}"
end
