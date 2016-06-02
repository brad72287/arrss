
### File Structure

```
├── CONTRIBUTING.md
├── Gemfile
├── Gemfile.lock
├── LICENSE.md
├── README.md
├── Rakefile
├── app
│   ├── controllers
│   │   └── application_controller.rb
│   ├── models
│   │   ├── tweet.rb
│   │   └── user.rb
│   └── views
│       ├── index.erb
│       ├── layout.erb
│       ├── tweets
│       │   ├── create_tweet.erb
│       │   ├── edit_tweet.erb
│       │   ├── show_tweet.erb
│       │   └── tweets.erb
│       └── users
│           ├── create_user.erb
│           └── login.erb
├── config
│   └── environment.rb
├── config.ru
├── db
│   ├── development.sqlite
│   ├── migrate
│   │   ├── 20151124191332_create_users.rb
│   │   └── 20151124191334_create_tweets.rb
│   ├── schema.rb
│   └── test.sqlite
└── spec
    ├── controllers
    │   └── application_controller_spec.rb
    └── spec_helper.rb
```
### Models

You'll need to create two models in `app/models`, one `User` model and one `Tweet`. Both classes should inherit from `ActiveRecord::Base`.

### Migrations

You'll need to create two migrations to create the users and the tweets table.

Users should have a username, email, and password, and have many tweets.

Tweets should have content, belong to a user.

### Associations

You'll need to set up the relationship between users and tweets. Think about how the user interacts with the tweets, what belongs to who?


### Home Page

You'll need a controller action to load the home page. You'll want to create a view that will eventually link to both a login page and signup page. The homepage should respond to a GET request to `/`.

### Create Tweet

You'll need to create two controller actions, one to load the create tweet form, and one to process the form submission. The tweet should be created and saved to the database. The form should be loaded via a GET request to `/tweets/new` and submitted via a POST to `/tweets`.

### Show Tweet

You'll need to create a controller action that displays the information for a single tweet. You'll want the controller action respond to a GET request to `/tweets`.

### Edit Tweet

You'll need to create two controller actions to edit a tweet: one to load the form to edit, and one to actually update the tweet entry in the database. The form to edit a tweet should be loaded via a GET request to `/tweets/:id/edit`. The form should be submitted via a POST request to `/tweets/:id`.

You'll want to create an edit link on the tweet show page.

### Delete Tweet

You'll only need one controller action to delete a tweet. The form to delete a tweet should be found on the tweet show page.

The delete form doesn't need to have any input fields, just a submit button.

The form to delete a tweet should be submitted via a POST request to `tweets/:id/delete`.

### Sign Up

You'll need to create two controller actions, one to display the user signup and one to process the form submission. The controller action that processes the form submission should create the user and save it to the database.

The form to sign up should be loaded via a GET request to `/signup` and submitted via a POST request to `/signup`.

The signup action should also log the user in and add the `user_id` to the sessions hash.

Make sure you add the Signup link to the home page.

### Log In

You'll need two more controller actions to process logging in: one to display the form to log in and one to log add the `user_id` to the sessions hash.

The form to login should be loaded via a GET request to `/login` and submitted via a POST request to `/login`.

### Log Out

You'll need to create a controller action to process a GET request to `/logout` to log out. The controller action should clear the session hash

### Protecting The Views

You'll need to make sure that no one can create, read, edit or delete any tweets.

You'll want to create two helper methods `current_user` and `is_logged_in`. You'll want to use these helper methods to block content if a user is not logged in.

It's especially important that a user should not be able to edit or delete the tweets created by a different user. A user can only modify their own tweets.
