require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do

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
    fill_in :email, with: 'test@example.com'
    fill_in :password, with: 'password'
    click_button 'Login'
  end

  scenario "My Cart increases from 0 to 1 when 'Add' is clicked once" do
    # ACT
    click_button 'Add', match: :first
    
    # DEBUG
    sleep 1.seconds
    save_screenshot

    # VERIFY
    expect(page).to have_text 'My Cart (1)'
  end

  scenario "My Cart increases from 0 to 1 when the same 'Add' is clicked multiple times" do
    # ACT
    click_button 'Add', match: :first
    click_button 'Add', match: :first
    
    # DEBUG
    sleep 1.seconds
    save_screenshot

    # VERIFY
    expect(page).to have_text 'My Cart (1)'
  end

  scenario "My Cart increases from 0 to 2 when two distinct 'Add' buttons are clicked" do
    # ACT
    click_button 'Add', match: :first
    page.all('button', text: 'Add')[2].click
    
    # DEBUG
    sleep 5.seconds
    save_screenshot

    # VERIFY
    expect(page).to have_text 'My Cart (2)'
  end

end