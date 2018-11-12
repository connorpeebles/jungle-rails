# Jungle

A mini e-commerce application built with Rails 4.2 for purposes of teaching Rails by example.

## Final Product

#### Screenshot of the products homepage
![Products](https://github.com/connorpeebles/jungle-rails/blob/master/screenshots/Products.png)

#### Screenshot of a product details page
![Product](https://github.com/connorpeebles/jungle-rails/blob/master/screenshots/Product.png) 

#### Screenshot of the order confirmation page
![OrderConfirmation](https://github.com/connorpeebles/jungle-rails/blob/master/screenshots/OrderConfirmation.png)

#### Screenshot of an admin page
![Admin](https://github.com/connorpeebles/jungle-rails/blob/master/screenshots/Admin.png)

## Added Features

* Visitors may create and log into their account using their email and password; the email is verified to be unique and the password is encrypted.
* When a user places an order, they are redirected to an order details page, which includes a summary of the items they purchased, the total amount charged to their card, and the email address that the order confirmation email was sent to.
* An order confirmation email is sent to the email address associated with the user's account when they place an order.
* A user may rate and review a product; the user may delete a rating they have previously created, and are limited to leave only one rating per product. A visitor may view the ratings and reviews for a product, but may not rate/review the product themselves.
* Admin users may view all the categories of products, and add a new category as well as add new products using the new category.
* When a category has 0 quantity, a sold out badge is displayed on the product list page.

## Fixed Bugs

* A user must enter HTTP authentication login/password to access admin functionality.
* When the cart is empty and the user views their cart, a message is displayed indicating that their cart is empty, and a link to continue shopping is displayed.
* When a user successfully completed an order, the quantities in the store are updated.
* When the quantity in a user's cart reaches the total quantity available for the product, the user is not able to add any more of that product to their cart.

## Setup

1. Fork & Clone
2. Run `bundle install` to install dependencies
3. Create `config/database.yml` by copying `config/database.example.yml`
4. Create `config/secrets.yml` by copying `config/secrets.example.yml`
5. Run `bin/rake db:reset` to create, load and seed db
6. Create .env file based on .env.example
7. Sign up for a Stripe account
8. Put Stripe (test) keys into appropriate .env vars
9. Run `bin/rails s -b 0.0.0.0` to start the server

## Stripe Testing

Use Credit Card # 4111 1111 1111 1111 for testing success scenarios.

More information in their docs: <https://stripe.com/docs/testing#cards>

## Dependencies

* Rails 4.2 [Rails Guide](http://guides.rubyonrails.org/v4.2/)
* PostgreSQL 9.x
* Stripe
