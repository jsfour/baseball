FactoryGirl.define do
  factory :player do
    first_name "Nolan"
    last_name "Ryan"
    sequence(:number, 1)
    team
  end
end
