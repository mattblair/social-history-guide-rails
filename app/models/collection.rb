class Collection < ActiveRecord::Base
  attr_accessible :author, :description, :geographical_scope, :geographical_title, :latitude, :longitude, :published, :title
end
