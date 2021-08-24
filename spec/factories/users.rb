FactoryBot.define do

  factory :user do
    
    name                  {"test"}
    email                 {"user1@example.com"}
    password              {"password"}
    encrypted_password    {"password"}
    introduction          {"enjoy cooking!"}
    
  end
  
end