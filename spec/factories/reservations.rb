FactoryGirl.define do
  factory :reservation do
    email 'coyote@acme.org'

    trait :confirmed do
      first_name    'Coyote'
      last_name     'Acme'
      phone_number  '1234567890'
    end


    trait :completed do
      confirmed

      housing_date  { Date.today }
      dark_wish     'Catch the Road Runner'
    end

    trait :rated do
      rating        { rand(1..5) }
    end

  end
end