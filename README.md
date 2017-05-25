# Factory Girl Spike

## Setup Instructions

1. Clone down this repo:
`git clone https://github.com/lao9/factory_girl_spike.git`

2. Check out exercise branch to practice setup and obstacle course:
`git checkout factory-girl-skate-park`

3. Update Gemfile:

````
group :development, :test do
  ...
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'launchy'
  gem 'shoulda-matchers'
end
````

4. Don't forget to bundle!  `bundle install`

5. Configure DatabaseCleaner

  In `rails_helper.rb` find the line `config.use_transactional_fixtures = true` and
change `true` to `false`.  If you are curious what this does, look [here](https://www.relishapp.com/rspec/rspec-rails/docs/transactions)

  In your console: `mkdir spec/support`

  And then: `touch spec/support/database_cleaner.rb` This is where you will put your DatabaseCleaner configuration for RSpec.

  Open that file and add the code :

```ruby
RSpec.configure do |config|
  config.before(:suite) do
    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean_with(:truncation)
    end
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
```

  If you would like an explanation of what each line of code in this file does, look [here](http://www.virtuouscode.com/2012/08/31/configuring-database_cleaner-with-rails-rspec-capybara-and-selenium/) and [here](http://mczuchnowski.github.io/blog/validating-factorygirl-factories)

  Finally, look in `rails_helper.rb`, find the line:

```ruby
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
```

and uncomment it.  This will allow rails to find all the the files in your newly created `spec/support` directory.

Configuring FactoryGirl

`touch spec/support/factory_girl.rb`

Open that file and write:

```
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
```

Configuring Should-Matchers

Open `rails_helper.rb` and place this code at the bottom of the file.

  ```ruby
  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
  ```

  Setup Database

  `rake db:setup`

Once all set, we'll walk through how to replace our current model tests on this branch with factories for the setup and shoulda-matchers for attribute and relationship validation.

## Additional Resources:

* Faker gem docs:
* Factory girl docs:
* Shoulda-Matchers docs:
* [Nick's rails setup guide](https://gist.github.com/NicholasJacques/6bf2a7733055844e6b5e6a73025726bc)
