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

- IMPORTANT OBSERVATION ABOUT DESTROY (DELETE) LINKS:
    - "You need to go to section 7.5 of the https://guides.rubyonrails.org/getting_started.html. It explains why:
        - "we need to set the data-turbo-method and data-turbo-confirm HTML attributes of the "Destroy" link."
    - Read the entire section 7.5, including the destroy action in both examples. Also preserve log in your console and observe the errors when you click on Delete button. To avoid head slapping moments, in destroy action try to add status to redirect_to as per rails guides redirect_to whatever_path, status: :see_other this also applies to when you delete an object and render new, you need to set status :unprocessable_entity which leads to server response to 422.
    - the key here is to ensure you have turbo_method: :delete in your link_to for Turbo, then, method: :delete to change GET to delete, and finally your destroy action to have a status when you're using redirect_to in-order to avoid errors when/if browser redirects you to another location with DELETE method."
    - https://guides.rubyonrails.org/getting_started.html
    - https://stackoverflow.com/questions/70446101/ruby-on-rails-7-delete-method-not-working



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

- Devise View Styling

- Associate User with Todo Lists
    - rails g migration add_user_id_to_todo_list user_id:integer:index
    - rails db:migrate
    - Check only the owner user can edit them todo lists:
        - def correct_user
            @todo_list = current_user.todo_list.find_by(id: params[:id])
            redirect_to todo_lists_path, notice: "Not Authorized To Edit This Todo List" if @todo_list.nil?
        end
    - Showing only the todo lists which owners to current user:
        - <% if todo_list.user == current_user %>

- Home page:
    - if user_signed_in? -> todo_lists#index (todo_lists page)
    - else -> users#sign_in (login page)

- Stimulus Reflex not working!
    - Action Cable aparentemente