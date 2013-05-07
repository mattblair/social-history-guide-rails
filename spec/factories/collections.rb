# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :collection do
    title "MyString"
    description "MyText"
    author "MyString"
    geographical_title "MyString"
    geographical_scope "MyText"
    latitude 1.5
    longitude 1.5
    published false
  end
end
