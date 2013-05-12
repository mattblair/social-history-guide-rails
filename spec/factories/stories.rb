# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :story do
    title "MyString"
    subtitle "MyString"
    summary "MyText"
    audio_filename "MyString"
    original_audio_filename "MyString"
    image_name "MyString"
    image_credit "MyString"
    thumbnail_name "MyString"
    twitter_template "MyString"
    editorial_notes "MyText"
    editing_priority 1
    audio_transcription "MyText"
    display_order 1
    keywords "MyString"
    latitude 1.5
    longitude 1.5
  end
end
