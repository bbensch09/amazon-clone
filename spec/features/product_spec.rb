require 'rails_helper'

describe "the product views for any user", :type => :feature do
  let!(:product) {FactoryGirl.create :product}

  context "product information" do
    it "shows a product list view with all products" do
      visit products_path
      expect(page).to have_content(product.title)
    end

    it "shows the product details for a particular product" do
      visit products_path(product)
      expect(page).to have_content(product.price)
    end
  end
end

describe "no product creation/update/delete functionality for non-admins" do
  let!(:product) {FactoryGirl.create :product}
  let!(:user) {FactoryGirl.create :user}
  before(:each) do
    visit new_user_session_path
    fill_in 'user_email', :with => user.email
    fill_in 'user_password', :with => user.password
    click_button 'Log in'
  end

  context "product creation" do
    it "does not let a non-admin user create a new product" do
      visit new_product_path
      expect(page).to have_content 'List of all'
    end
  end

end

describe "product creation/update/delete functionality for admins" do
  let!(:product) {FactoryGirl.create :product}
  let!(:admin) {FactoryGirl.create :admin}
  before(:each) do
    visit new_user_session_path
    fill_in 'user_email', :with => admin.email
    fill_in 'user_password', :with => admin.password
    click_button 'Log in'
  end

  context "product creation" do
    it "creates a new product" do
      visit new_product_path
      fill_in 'product[title]', with: product.title
      fill_in 'product[description]', with: product.description
      fill_in 'product[image_url]', with: product.image_url
      fill_in 'product[price]', with: product.price
      fill_in 'product[inventory_quantity]', with: product.inventory_quantity
      select(category.name, :from => 'product[category_id]')
      fill_in 'product[brand_id]', with: product.brand_id
      fill_in 'product[supplier_id]', with: product.supplier_id
      click_on 'Create or Update Product'
      expect(page).to have_content product.title
    end

    it "doesn't create a new product if required fields aren't filled out" do
      visit new_product_path
      fill_in 'product[title]', with: product.title
      fill_in 'product[image_url]', with: product.image_url
      fill_in 'product[price]', with: product.price
      fill_in 'product[inventory_quantity]', with: product.inventory_quantity
      select(category, :from => 'product[category_id]')
      fill_in 'product[brand_id]', with: product.brand_id
      fill_in 'product[supplier_id]', with: product.supplier_id
      click_on 'Create or Update Product'
      expect(page).to have_content 'Prevented this product from being saved'
    end
  end

  describe "product update" do
    before(:each) do
      visit edit_product_path(product)
    end
    it "updates an existing product" do
      new_title = "Best Shoes Ever"
      fill_in 'product[title]', with: new_title
      click_on 'Create or Update Product'
      expect(page).to have_content new_title
    end
    it "doesn't update an existing product when a required field is missing" do
      new_title = ""
      fill_in 'product[title]', with: new_title
      click_on 'Create or Update Product'
      expect(page).to have_content 'Prevented this product from being saved'
    end

  end

  describe "product deletion" do
    before(:each) do
      visit product_path(product)
    end
    it "has a button to delete the product" do
      click_on 'Destroy'
      expect(page).to_not have_content(product.title)
    end
  end


end
