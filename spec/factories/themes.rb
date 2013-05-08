# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :theme do
    title "MyString"
    subtitle "MyString"
    summary "MyText"
    image_name "MyString"
    image_credit "MyString"
    twitter_template "MyString"
    editorial_notes "MyText"
    latitude 1.5
    longitude 1.5
    displayOrder 1
    keywords "MyString"
  end
end
