# Contact Importer App

## Intro

This project allows for user registration, signin, signout, import csv files, introduce your own file headers (which is mandatory) to match to the app's, check for uploaded files which show the current state of file and any import errors associated with that file, check for imported contacts. This app was made using Ruby on Rails (RoR) framework with focus mostly on backend functionalities but it includes a basic view to use.

## How users can get started with?

### Pre-requisites

Before starting, it is necessary to have already installed and configured in your system:
  - Git ver. 2.11+
  - Ruby ver. 2.7.2+
  - Ruby on rails ver. 6.1.3+ (running on port 3000)
  - SQLite3 ver. 3.31.1+
  - NodeJS ver. 14.16.0+
  - Yarn 1.22.10+
  - Redis 5.0.7+
  

### Start

Clone the repository to have the local project:
``` sh
git clone git@github.com:SneyderHOL/contact-importer.git
```

Get inside the path of the project:
``` sh
cd contact-importer
```

Installing dependecies:
``` sh
yarn install
```
``` sh
bundle install
```

Create database tables:
``` sh
rails db:migrate
```

Run sideqik:
``` sh
bundle exec sideqik
```

In another console

Run app:
``` sh
rails s
```

Checking app from browser at:

localhost:3000
