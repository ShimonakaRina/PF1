FactoryBot.define do
  factory :cook do
    
    title                 {"test"}
    body                  {"sample"}
    created_at            {"2021-08-23"}
    updated_at            {"2021-08-23"}
    association :user
    
  end
end