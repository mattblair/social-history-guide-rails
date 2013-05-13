# == Schema Information
#
# Table name: collections
#
#  id                  :integer          not null, primary key
#  title               :string(255)
#  description         :text
#  author              :string(255)
#  geographical_title  :string(255)
#  geographical_scope  :text
#  latitude            :float
#  longitude           :float
#  published           :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  sponsor_name        :string(255)
#  sponsor_description :text
#  sponsor_logo_name   :string(255)
#  sponsor_url         :text
#  curator_name        :string(255)
#  curator_url         :text
#

require 'spec_helper'

describe Collection do
  pending "add some examples to (or delete) #{__FILE__}"
end
