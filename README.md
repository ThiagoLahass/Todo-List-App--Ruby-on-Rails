# To-Do List Project - Ruby on Rails

## Table of Contents
1. [Installation Instructions](#installation-instructions)
2. [Creating a New Rails Project](#creating-a-new-rails-project)
3. [Adding Features](#adding-features)
    - [Todo List and Todo Item Models](#todo-list-and-todo-item-models)
    - [User Authentication with Devise](#user-authentication-with-devise)
    - [Styling Devise Views](#styling-devise-views)
4. [Routing and Views](#routing-and-views)
5. [Screenshots](#screenshots)
6. [Deploying the Application](#deploying-the-application)

---

## Installation Instructions

### 1. Install Ruby on Ubuntu 24.04 LTS
Follow this guide to install Ruby:
- [How to Install Ruby in Ubuntu 24.04 LTS](https://ubuntuhandbook.org/index.php/2024/01/install-ruby-ubuntu-24-04/)

### 2. Install Rails
Install Rails using the command:
```bash
gem install rails
```

### 3. Create a New Rails Project
Generate a new Rails project:
```bash
rails new project_name
```

### 4. Generate the Home Page
Generate a controller for the home page:
```bash
rails g controller home index
```

### 5. Add `nested_scaffold` Gem
Add the `nested_scaffold` gem to your Gemfile:
```ruby
gem 'nested_scaffold', '~> 1.1'
```
[Gem Documentation](https://rubygems.org/gems/nested_scaffold)

### 6. Create the Models
Generate the `TodoList` and `TodoItem` models with the following commands:
```bash
rails g scaffold TodoList title
rails g nested_scaffold TodoList/TodoItem description:text completed:boolean completed_at:datetime todo_list:references
```

### 7. Update Database
Run the migration:
```bash
rails db:migrate
```

---

## Adding Features

### Todo List and Todo Item Models
Set up your models by generating the necessary scaffolds and adding the relationship between `TodoList` and `TodoItem`.

Update `config/routes.rb`:
```ruby
resources :todo_lists do
    resources :todo_items
end
```

### User Authentication with Devise
Install the Devise gem to handle user authentication:
```ruby
gem 'devise', '~> 4.9', '>= 4.9.4'
```

Run the following commands:
```bash
bundle install
rails g devise:install
rails g devise user
rails db:migrate
```

### Styling Devise Views
Generate and style Devise views as needed to match your application's UI.

---

## Routing and Views

### Home Page
On the home page:
- If the user is signed in: Show the `todo_lists#index` page.
- If not signed in: Redirect to `users#sign_in` (login page).

### User Authorization for Todo Lists
To ensure that only the owner of a `TodoList` can edit it:
```ruby
def correct_user
    @todo_list = current_user.todo_list.find_by(id: params[:id])
    redirect_to todo_lists_path, notice: "Not Authorized To Edit This Todo List" if @todo_list.nil?
end
```

### Showing Only User's Todo Lists
In the `todo_lists` view, make sure to display only the lists that belong to the current user:
```erb
<% if todo_list.user == current_user %>
    <!-- Show Todo List -->
<% end %>
```

---

## Screenshots

Below are the screenshots of the key pages in the application.

### Login and Sign Up
Here is how the login and sign-up screens will look side by side:

| Login Screen | Sign Up Screen |
|--------------|----------------|
| ![Login](app/assets/images/login.png) | ![Sign Up](app/assets/images/signup.png) |

### Home Page - Todo Lists
The initial screen showing the user's todo lists:
![Todo Lists](app/assets/images/todo_lists_index.png)

### Todo List Details
This screen displays the items within a selected todo list:
![Todo List Details](app/assets/images/todo_list_show.png)

### Todo Item Edit
The screen for editing a specific todo item:
![Todo Item Edit](app/assets/images/todo_item_edit.png)

---

## Deploying the Application

### Deploy to Render
The application has been deployed on Render:
[To-Do List App](https://todo-list-app-ruby-on-rails.onrender.com/)

### Steps to Deploy

#### 1. Change SQLite to PostgreSQL
Run the following command to change the database system:
```bash
rails db:system:change --to=postgresql
```

#### 2. Install PostgreSQL on Linux
Install PostgreSQL using the commands below:
```bash
sudo apt update
sudo apt install postgresql postgresql-contrib
sudo systemctl start postgresql.service
```

#### 3. Create and Migrate Database
Run the following commands to set up the database:
```bash
rails db:create
rails db:migrate
```

#### 4. Fix Database Permission Errors
If you encounter a "permission denied" error, follow these steps:
1. Open the PostgreSQL console:
    ```bash
    sudo -u postgres psql
    ```
2. Create a user and grant privileges:
    ```sql
    CREATE USER your_username WITH PASSWORD 'your_password';
    ALTER ROLE your_username CREATEDB;
    GRANT ALL PRIVILEGES ON DATABASE your_database_name TO your_username;
    \q
    ```

#### 5. Upload Project to GitHub
Push your project to a GitHub repository.

#### 6. Configure Render Deployment
1. Create a file named `render-build.sh` in your repo’s `bin` directory and paste the following:
    ```bash
    #!/usr/bin/env bash
    # exit on error
    set -o errexit

    bundle install
    bundle exec rails assets:precompile
    bundle exec rails assets:clean
    ```

2. Create a file named `render.yaml` in the root directory with the following content:
    ```yaml
    databases:
      - name: mysite
        databaseName: mysite
        user: mysite
        plan: free

    services:
      - type: web
        name: mysite
        runtime: ruby
        plan: free
        buildCommand: "./bin/render-build.sh"
        startCommand: "bundle exec rails server"
        envVars:
          - key: DATABASE_URL
            fromDatabase:
              name: mysite
              property: connectionString
          - key: RAILS_MASTER_KEY
            sync: false
          - key: WEB_CONCURRENCY
            value: 2
    ```

3. Follow the detailed guide from Render’s documentation:
    [Render Rails Deployment Guide](https://render.com/docs/deploy-rails)

---

Thank you for checking out this project! If you found it helpful, please consider giving it a ⭐. Your support is greatly appreciated!

