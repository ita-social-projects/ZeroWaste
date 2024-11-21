<a href="https://softserve.academy/"><img src="https://s.057.ua/section/newsInternalIcon/upload/images/news/icon/000/050/792/vnutr_5ce4f980ef15f.jpg" title="SoftServe IT Academy" alt="SoftServe IT Academy"></a>

# ZERO WASTE

#### [Staging](https://zero-waste-staging.onrender.com/)

# 1. About the project

<img src='logo.jpg' alt='zero-waste'>
Zero Waste Lviv is a Public Organization that works on the implementation of waste reduction principles in Lviv and Ukraine. Organization draws attention of the city and businesses by conducting trainings, meetings, workshops and research to support ‘zero waste’ grounds. Organization conducts a campaign to draw attention to the problem of using disposable hygiene products for women and children and possible ways or reduction. Website - https://zerowastelviv.org.ua

In order to attract attention to financial and ecological consequences of disposable diaper usage it is planned to create a module that will calculate budget spent on diapers and calculations of the future expenses. As visual representation it is planned to show the volume of waste that was made during usage of disposable diapers for one child.

- [Deployed Apps and Environments](#deployed-apps-and-environments)
- [Installation](#installation)
  - [Required to install](#Required-to-install)
  - [Clone](#Clone)
  - [Local setup](#Setup)
  - [How to run local](#How-to-run-local)
- [Usage](#Usage)
  - [How to run Rubocop](#How-to-run-Rubocop)
  - [Git-hook pre-commit](#Git-hook-pre-commit)

## Deployed Apps and Environments

The latest version from the 'develop' branch is automatically deployed to stage environment in Render, [staging link](https://zero-waste-staging.onrender.com/).
The latest version from the release branch 'master' is automatically deployed to Production environment, [production link](http://calc.zerowastelviv.org.ua/).

## Installation

- Start the project locally

# Required to install

- Ruby 3.3.5
- Ruby on Rails 7.1.2
- PostgreSQL 12
- Puma as a web server
- Yarn
- Bootstrap

## Clone

$ `git clone https://github.com/ita-social-projects/ZeroWaste.git`

## Local setup

First of all you need RVM to setup project. For the operating system Windows the optimal solution is to use <a href="https://docs.microsoft.com/en-us/windows/wsl/">WSL</a>.

$ `bin/setup`
or
$ `bundle install`

<b>Install the following packages:</b>

`sudo apt install imagemagick`

`sudo apt install libvips42`

<b>PostgreSQL</b>

<a href="https://www.postgresql.org/download/">Install PostgreSQL</a> for your operating system or subsystem.
You can familiarize yourself with <a href="https://www.postgresql.org/docs/">PostgreSQL documentation</a>.

To check if it is installed and running correctly run `sudo systemctl status postgresql`

In your local machine in cloned project in config folder rename database.yml.sample to database.yml. Make sure that the user and password match the data in this file. Port may be changed.

For further work, make sure that you have a user 'postgres' with superuser. If is no that one do next:
$ `sudo -u user psql user`
$ `CREATE USER postgres SUPERUSER;`
$ `CREATE DATABASE postgres WITH OWNER postgres;`

If you're having trouble authenticating, you may need to reset your password. You can <a href="https://stackoverflow.com/questions/55038942/fatal-password-authentication-failed-for-user-postgres-postgresql-11-with-pg">read</a> instruction how to do it.

<b>pg gem</b>

Under certain circumstances bundle can do not install pg.

To install manually:
$ `sudo apt-get install libpq-dev`
then
$ `gem install pg`

<b>Database configure</b>

For correct operation of the migration, you need to rename the migration file `20220123171144_create_versions.rb` so that it is processed first.

To create the necessary databases and update them:

$ `rake db:create`
then
$ `rake db:migrate`

$ `rake db:reset` can resolve some errors connected with database.

<b>Redis</b>

You need Redis for correct work.
<a href="https://redis.io/docs/getting-started/">Install Redis</a> for your operating system or subsystem. You can familiarize yourself with
<a href="https://redis.io/docs//">Redis documentation</a>.

Installation for Ubuntu:

$ `curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg`

```shell
echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list
```

$ `sudo apt-get update`
$ `sudo apt-get install redis`

To check if it is installed and running correctly run `sudo systemctl status redis`

<b>npm and Node.js</b>

Also you need Node.js.
<a href="https://nodejs.org/en/download/">Install npm and Node.js</a> for your operating system or subsystem. You can familiarize yourself with
<a href="https://nodejs.org/en/about/">npm and Node.js documentation</a>

<b>yarn</b>

You can read more about yarn there:
<a href="https://classic.yarnpkg.com/lang/en/docs/">yarn documentation</a>.

Installation:
$ `npm install --global yarn`

<b>Webpacker</b>

To prevent an error when starting the server install webpacker. You can read more about webpacker there:
<a href="https://guides.rubyonrails.org/webpacker.html">Webpacker documentation</a>.

Installation:
$ `yarn add @rails/webpacker`
$ `bundle update webpacker`

<b>Sidekiq</b>

Simple, efficient background processing for Ruby. You can read more about sidekiq there:
<a href="https://github.com/mperham/sidekiq">Sidekiq documentation</a>.

Installation:
$ `bundle add sidekiq`

## How to run local

1. Ensure that postgresql and redis are running
2. Run `rails assets:precompile` to precompile assets
3. Run `bin/rails tailwindcss:watch` with `rails server` to watch for changes in tailwind and start server or run `bin/dev`
4. Open http://localhost:3000 to view it in the browser.

Solutions when an errors occurs:
<a href="https://stackoverflow.com/questions/15301826/psql-fatal-role-postgres-does-not-exist">psql: FATAL: role "postgres" does not exist</a>

If you have Webpacker::Manifest::MissingEntryError you can try next steps:
$ `rm -rf node_modules`
$ `rails webpacker:install`
$ `yarn install`

# Usage

# How to run Rubocop

Running rubocop with no arguments will check all Ruby source files in the current folder:

$ `rubocop`

Alternatively you can pass rubocop a list of files and folders to check:

$ `rubocop app spec lib/something.rb`

For more details check the available command-line options:

$ `rubocop -h`

# Git-hook pre-commit

Before using `git-hook-pre-commit` you need to install `sudo apt-get install cmake`

For using `git-hook-pre-commit` type `cp git-hooks/pre-commit .git/hooks/pre-commit` command to install your hook.

Run `git commit -m "name"` to commit changes locally.
If you have some troubles with style conventions after running `git commit -m "name"`, you need to run `rubocop -a` or `rubocop -A`. Each of these commands can resolve the majority of warnings.

Type `git commit -m "name" --no-verify` for commiting without formating.

[![Rubocop](https://github.com/ita-social-projects/ZeroWaste/actions/workflows/rubocop.yml/badge.svg)](https://github.com/ita-social-projects/ZeroWaste/actions/workflows/rubocop.yml)

[![Rspec](https://github.com/ita-social-projects/ZeroWaste/actions/workflows/ci.yml/badge.svg)](https://github.com/ita-social-projects/ZeroWaste/actions/workflows/ci.yml)

[![.github/workflows/staging.yml](https://github.com/ita-social-projects/ZeroWaste/actions/workflows/staging.yml/badge.svg)](https://github.com/ita-social-projects/ZeroWaste/actions/workflows/staging.yml)

[![.github/workflows/production.yml](https://github.com/ita-social-projects/ZeroWaste/actions/workflows/production.yml/badge.svg)](https://github.com/ita-social-projects/ZeroWaste/actions/workflows/production.yml)
