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

In another console (same path inside contact-importer directory)

Run app:
``` sh
rails s
```

Checking app from browser at:

localhost:3000


## Using app with supplied app user and test csv files

Add users from seed file
``` sh
rails db:seed
```

Run sidekiq and app (see above for commands)

Inside the app try to signin with any of these users:

Email -> aryastark@example.com
Password -> testuser

Email -> frodo@example.com
Password -> myuser

Select the Import Contact link in the navigation bar and select the contacts.csv file inside the repo directory as the file to upload

Pair the header values with the corresponding contact field in the form, like:

(contacts info) -> (csv headers)
Name -> ctc_fullname
Birthdate -> ctc_birthdate
Phone -> ctc_phone_number
Address -> ctc_address
Credit Card -> ctc_credit_card
Email -> ctc_email

Click the import button

You can see the state of your file process in the Uploaded File link.
You can see the imported contacts in the Contatcs link.

Depending in the state of your file you could see the failed registers from each file, for this case you could try upload the second test file provided with the name contacts_repeated.csv

Same process as before.

Import Contacts link.
Select File (in this case contacts_repeated.csv)
Header Pairing in the form (same headers as before)
Click button Import

In the Uploaded File section wait for the file to have a "finished" status, then you will see a link to failed registers with the corresponding errors associated with the file, like bad headers, wrong data format, invalid fields.

For this last example, you will see that:
A couple of new contacts were inserted
Severall failed registers with the message of repeated contacts email
Severall failed registers with the message of invalid fields or wrong data formats.


## Note

If you want to use your own csv file, you could use different headers (right column from above) but with the same mandatory contacts info fields (left column from above) but it is necessary to do the pairing headers when upload the csv file.
