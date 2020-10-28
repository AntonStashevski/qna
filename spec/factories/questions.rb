include ActionDispatch::TestProcess

FactoryBot.define do
  factory :question do
    title { 'MyQuestionTitle' }
    body { 'MyQuestionBody' }
    user

    trait :invalid do
      title { nil }
      user
    end

    trait :file do
      before :create do |question|
        question.files.attach Rack::Test::UploadedFile.new("#{Rails.root}/spec/rails_helper.rb")
      end
    end

    trait :link do
      before :create do |question|
        question.links.new(name: "test", url: "https://www.test.com/").save!
      end
    end

    trait :reward do
      before :create do |question|
        create(:reward,
               question: question,
               title: 'BEST',
               file: fixture_file_upload(Rails.root.join('spec', 'images', 'image.jpg')))
      end
    end
  end
end
