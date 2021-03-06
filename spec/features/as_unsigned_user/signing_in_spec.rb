require 'spec_helper'

describe "Signing in" do
  subject { page }

  before { visit signin_path }
  
  describe "With valid, case-insensitive information" do
    let(:user_attr) { FactoryGirl.build(:user) }
    let!(:user) { FactoryGirl.create(:user) }

    before do
      fill_in 'Username',   with: user_attr.username.upcase
      fill_in 'Password',   with: user_attr.password
      click_button 'Sign in'
    end

    it { should have_selector('div.success')}
    it { should have_title(full_title('')) }
    it { should have_link('Sign out') }
    it { should have_link('Profile') }
    it { should_not have_link('Sign in') }
    it { should_not have_link('Sign up') }

    describe "The user is remembered after he logs in" do
      # @user variable needs to be reloaded first:
      before { @user = User.find(user.id) }
      it { expect(@user.remember_me_token).not_to be_blank }
    end

    describe "User links" do
      it "Should have a Profile link that works" do
        click_link "Profile"
        page.should have_title(full_title(user.display_name)) 
      end

      it "Should have a Sign out link that works" do
        click_link "Sign out"
        page.should have_selector("div.notice", text: "signed out") 
      end
    end
  end

  describe "With invalid information" do
    before { click_button "Sign in" }
    it { should have_title(full_title('Sign in')) }
    it { should have_selector('div.alert', text: "Login failed.") }
  end
end
