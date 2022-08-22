# Instagram Clone

Instagram clone is a test project in ruby on rails. It has the functionality for sign up and login. User can create and delete posts and stories. User can also see post and stories of other users that they follow. User are of two types Private and Public

## Versions

* Ruby version: ruby 2.6.0p0 (2018-12-25 revision 66547) [x86_64-darwin19]
* Rails version: Rails 5.2.8.1


## Dependencies

* Postgresql
* Devise
* pundit
* Cloundinary

### Database Creation
Postgress has been used in this Project, new database can be created using following commands.

```bash
rails db:drop
rails db:create
rails db:migrate
```

### Database Initialization
Database can be initialized by running.

```bash
rails db:seed
```

### Background Jobs
User stories will be automatically deleted, as I have setup the background job using sidekiq.

### Deployment Instructions

```bash
heroku login
heroku create #This will create new application.
heroku rename #If you want to rename your application.
git push heroku main
heroku run rails db:migrate
```

