FactoryBot.define do
  pw = RandomData.random_sentence

  factory :user do
    username RandomData.random_word
    email RandomData.random_email
    password 'testpassword'
    password_confirmation 'testpassword'
    confirmed_at Date.today
  end
end
