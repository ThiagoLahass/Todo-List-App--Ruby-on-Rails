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