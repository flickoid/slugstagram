FactoryGirl.define do
  factory :user do

    factory :chris do
      email 'chris@factorygirl.com'
      password '12345678'
    end

    factory :vincent do
      email 'vincent@factoryboy.com'
      password '87654321'
    end
    
  end
end