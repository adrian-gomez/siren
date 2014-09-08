siren
=====

[SI]mple [RE]servation[N] app is a simple demo application of a timeshare reservation system.


Features
--------

It is build using rails 4 and tested using rspec 3.

Almost all parts of the app are tested and the coverage is 100% (simplecov is used for coverage
report)


Time
----

This app took 6-8 hours to get done. 


Setup
-----

The setup is really easy and is done like a normal rails app.

#### Clone the repo:

``$
git clone git@github.com:adrian-gomez/siren.git
``

#### Run bundle install

``$
bundle
``

#### Run the migrations and load seed data

``$
rake db:migrate db:seed
``

> As this is just a demo project sqlite is used for storage and database settings are included in
the repository, still if you want to change this just add the necessary gems and update config/database.yml
according to your needs.

#### Configure extra settings

``$
cp config/configuration{.sample,}.yml
``

``$
vi config/configuration.yml
``

> What you need to provide is a valid gmail account and its password for email delivery.

> The email host can we left alone if you are going to use the default method for stating the server,
if you wish to change the port where the application listens or if running behind a  reverse proxy
just change the email host accordingly.

#### Start the server

``$
rails s
``


Tests
-----

As stated above the testing is done using rspec, to run all the suite execute:

``$
rspec
``


Supported Platforms
-------------------

This app has been tested on:

* MRI 1.9.3
* MRI 2.1.1
* MRI 2.1.2
* JRuby 1.7.14

> While JRuby is supported some modifications need to be made: run the commands with bundle exec,
change the adapted in database.yml to jdbcsqlite3.

> If when running in JRuby you get: Illegal key size: possibly you need to install Java Cryptography Extension (JCE) Unlimited Strength Jurisdiction Policy Files for your JRE
just follow this: http://deployingjruby.blogspot.com/2013/05/how-to-run-rails-400rc1-on-jruby.html


License
-------

MIT License. Copyright 2014 Adrian Gomez (https://github.com/adrian-gomez)