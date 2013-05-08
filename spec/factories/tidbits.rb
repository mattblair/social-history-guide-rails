# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tidbit do
    title "MyString"
    year "MyString"
    publication_date "2013-05-07 20:58:33"
    twitter_template "MyString"
    latitude 1.5
    longitude 1.5
    editorial_notes "MyText"
    image_name "MyString"
    image_caption "MyString"
    image_credit "MyString"
    body "MyText"
    audio_filename "MyString"
    source "MyString"
    source_url "MyText"
  end
end
