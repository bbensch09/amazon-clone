require 'rails_helper'

describe "User and Admin account functionality" do
  before(:each) do
    @admin = FactoryGirl.create(:admin)
    @user = FactoryGirl.create(:user)
    @admin2 = FactoryGirl.create(:admin)
    # login_as (admin :scope => :user)
  end

    context "admin login works" do
      it "admin can sign in" do
        visit new_user_session_path
        fill_in 'Email', :with => @admin.email
        fill_in 'Password', :with => @admin.password
        click_button 'Log in'
        expect(page).to have_content 'successfully'
      end

      it "admin sign in fails with wrong credentials" do
        visit new_user_session_path
        fill_in 'Email', :with => @admin.email
        fill_in 'Password', :with => '12345678'
        click_button 'Log in'
        expect(page).to have_content 'Invalid'
      end
    end

    context "admins can view all users" do
      it "shows a list of users when logged in as admin" do
        visit new_user_session_path
        fill_in 'Email', :with => @admin.email
        fill_in 'Password', :with => @admin.password
        click_button 'Log in'
        visit users_path
        expect(page).to have_content "List of all Users"
      end

    end

    context "user login works" do
      it "user can sign in" do
        visit new_user_session_path
        fill_in 'Email', :with => @user.email
        fill_in 'Password', :with => @user.password
        click_button 'Log in'
        expect(page).to have_content 'successfully'
      end

      it "admin sign in fails with wrong credentials" do
        visit new_user_session_path
        fill_in 'Email', :with => 'admin@tal.com'
        fill_in 'Password', :with => '12345678'
        click_button 'Log in'
        expect(page).to have_content 'Invalid'
      end
    end

    context "admins can give other users admin access" do
      it "admins can grant other users admin privileges" do
        visit new_user_session_path
        fill_in 'Email', :with => @admin.email
        fill_in 'Password', :with => @admin.password
        click_button 'Log in'
        visit edit_user_path(@user)
        check 'user_admin'
        click_button 'Update User'
        expect(page).to have_content "Admin? true"
      end

      it "admins can remove other user's admin privileges" do
        visit new_user_session_path
        fill_in 'Email', :with => @admin.email
        fill_in 'Password', :with => @admin.password
        click_button 'Log in'
        visit edit_user_path(@admin2)
        uncheck 'user_admin'
        click_button 'Update User'
        expect(page).to have_content "Admin? false"
      end
    end

    context "users can not access admin only pages" do
      it "users can not edit users" do
        visit new_user_session_path
        fill_in 'Email', :with => @user.email
        fill_in 'Password', :with => @user.password
        click_button 'Log in'
        visit edit_user_path(@admin2)
        expect(page).to_not have_content "Admin access?"
      end
    end
end
