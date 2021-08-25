FactoryBot.define do

  factory :favorite do

    association :cook
    user { cook.user }
  end

end