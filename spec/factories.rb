FactoryBot.define do
  factory :association do
    sequence(:id_association) { |n| "W000#{n}" }
  end
end
