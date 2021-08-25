FactoryBot.define do

  factory :notification do
    association :cook
    association :visiter
    association :visited
  end

end