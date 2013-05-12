# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :guest do
    name "MyString"
    title "MyString"
    organization "MyString"
    image_name "MyString"
    bio "MyText"
    twitter_template "MyString"
    editorial_notes "MyText"
    quote "MyText"
    guest_url "MyString"
    guest_url_text "MyString"
  end
end
