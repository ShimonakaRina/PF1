FactoryBot.define do

  factory :cook_comment do

    comment               {"test"}
    rate                  {"1"}
    association :cook
    user { cook.user }

  end
end