require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do

  # SETUP
  before :each do
    @user = User.create!(
      first_name: 'Test',
      last_name: 'User',
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password'
    )

    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 2,
        price: 64.99
      )
    end

    #login
    visit root_path
    click_on 'Login'
  end

  scenario "User is logged in when email and password are valid" do
    # ACT
    fill_in :email, with: 'test@example.com'
    fill_in :password, with: 'password'
    click_button 'Login'
    
    # DEBUG
    sleep 1.seconds
    save_screenshot

    # VERIFY
    expect(page).to have_text 'Welcome, Test'
    expect(page).to have_css 'article.product', count: 10
  end

  scenario "User is not logged in when password does not match email" do
    # ACT
    fill_in :email, with: 'test@example.com'
    fill_in :password, with: 'PASSWORD'
    click_button 'Login'
    
    # DEBUG
    sleep 1.seconds
    save_screenshot

    # VERIFY
    expect(page).to have_text 'Invalid email and/or password'
    expect(page).to have_css 'article.product', count: 10
  end

  scenario "User is not logged in when email does not exist" do
    # ACT
    fill_in :email, with: 'testy@example.com'
    fill_in :password, with: 'password'
    click_button 'Login'
    
    # DEBUG
    sleep 1.seconds
    save_screenshot

    # VERIFY
    expect(page).to have_text 'Invalid email and/or password'
    expect(page).to have_css 'article.product', count: 10
  end

  scenario "User is not logged in when fields are left blank" do
    # ACT
    click_button 'Login'
    
    # DEBUG
    sleep 1.seconds
    save_screenshot

    # VERIFY
    expect(page).to have_text 'Invalid email and/or password'
    expect(page).to have_css 'article.product', count: 10
  end

end