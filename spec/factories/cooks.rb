FactoryBot.define do

  factory :cook do

    title                 {"test"}
    body                  {"sample"}
    association :user

  end
end