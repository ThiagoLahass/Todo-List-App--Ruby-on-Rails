# README

- How to Install Ruby in Ubuntu 24.04 LTS
    - https://ubuntuhandbook.org/index.php/2024/01/install-ruby-ubuntu-24-04/

- Install Rails
    - gem install rails

- Create a new Rails project:
    - rails new project_name

- Generate the home page:
    - rails g controller home index

- Add nestes_scaffold gem
    - gem 'nested_scaffold', '~> 1.1'
    - https://rubygems.org/gems/nested_scaffold

- Create the models
    - rails g scaffold TodoList title
    - rails g nested_scaffold TodoList/TodoItem description:text completed:boolean completed_at:datetime todo_list:references

- Update database
    - rails db:migrate

- Update routes.rb
    ```ruby
        resources :todo_lists do
            resources :todo_items
        end
    ```

- Creating total, completed and percent completed items
- Making the form work
    - Progress bar
    - Status Badge
    - Add Todo Item input form
    - Stimulus reflex
        - bundle add stimulus_reflex
        - rails stimulus_reflex:install
        - rails g stimulus_reflex TodoItem

- User Devise Management
    - Add Devise gem to Gemfile:
        - gem 'devise', '~> 4.9', '>= 4.9.4'
    - Install the gem:
        - bundle install
    - Devise install on Rails:
        - rails g devise:install
    - Config config/environments/development.rb file:
        - config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
    - Generate Devise views:
        - rails g devise:views
    - Generate the User model:
        - rails g devise user
    - Migrate the database:
        - rails db:migrate
