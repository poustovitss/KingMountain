King Mountain
================
[Try out production](https://king-mountain.pro/)

###### Credentials for admin user on site: admin@admin.com, 'changemeadmin'

Earn money by playing.

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Build With
* Ruby 2.3.3
* Rails 5.0.2
* Bootstrap 3
* Deployed on [reg.ru](https://www.reg.ru/)

### Installing
A step by step series of examples that tell you have to get a development env running

Clone project:
```
$ git clone https://github.com/HardNeal/KingMountain.git
```

Rename database.yml.example to database.yml:
```
$ mv database.yml.example database.yml
```

Set `username` and `password` values right for your db settings in database.yml file.

Add secrets.yml:
```
$ rake secret
```

Setup db:
```
rails db:create db:migrate db:seed
```

Run server:
```
rails s
```

### Deployment
Deployed version: [https://king-mountain.pro/](https://king-mountain.pro/)