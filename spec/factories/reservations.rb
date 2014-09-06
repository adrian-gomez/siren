FactoryGirl.define do
  factory :reservation do
    email 'coyote@acme.org'

    trait :confirmed do
      first_name    'Coyote'
      last_name     'Acme'
      phone_number  '1234567890'
    end
  end
end