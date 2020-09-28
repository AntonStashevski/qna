require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:questions) }
  it { should have_many(:answers) }

  describe "author of method" do
    describe "question" do
      let(:user1) { create(:user) }
      let(:user2) { create(:user) }
      let(:question) { create(:question, user: user1) }

      it 'yes' do
        expect(user1).to be_author(question)
      end

      it 'no' do
        expect(user2).to_not be_author(question)
      end
    end

    describe "answer" do
      let(:user1) { create(:user) }
      let(:user2) { create(:user) }
      let(:answer) { create(:answer, user: user1) }

      it 'yes' do
        expect(user1).to be_author(answer)
      end
  
      it 'no' do
        expect(user2).to_not be_author(answer)
      end
    end
  end
end
