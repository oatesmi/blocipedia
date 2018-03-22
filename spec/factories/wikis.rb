FactoryBot.define do
  factory :wiki do
    title 'Test Title'
    body 'This is a test body. It should test out fine.'
    private false
    user
  end
end
