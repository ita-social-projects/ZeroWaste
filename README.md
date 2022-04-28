<a href="https://softserve.academy/"><img src="https://s.057.ua/section/newsInternalIcon/upload/images/news/icon/000/050/792/vnutr_5ce4f980ef15f.jpg" title="SoftServe IT Academy" alt="SoftServe IT Academy"></a>

# ZERO WASTE

# 1. About the project
<img src='logo.jpg' alt='zero-waste'>
Zero Waste Lviv is a Public Organization that works on the implementation of waste reduction principles in Lviv and Ukraine. Organization draws attention of the city and businesses by conducting trainings, meetings, workshops and research to support ‘zero waste’ grounds. Organization conducts a campaign to draw attention to the problem of using disposable hygiene products for women and children and possible ways or reduction. Website - https://zerowastelviv.org.ua 

In order to attract attention to financial and ecological consequences of disposable diaper usage it is planned to create a module that will calculate budget spent on diapers and calculations of the future expenses. As visual representation it is planned to show the volume of waste that was made during usage of disposable diapers for one child.

- [Deployed Apps and Environments](#deployed-apps-and-environments)
- [Installation](#installation)
  - [Required to install](#Required-to-install)
  - [Clone](#Clone)
  - [Setup](#Setup)
  - [How to run local](#How-to-run-local)
- [Usage](#Usage)
  - [How to run Rubocop](#How-to-run-Rubocop)
  - [Git-hook pre-commit](#Git-hook-pre-commit)
  
## Deployed Apps and Environments
The latest version from the 'develop' branch is automatically deployed to stage environment in Heroku, [staging link](https://zerowaste-staging.herokuapp.com/).
The latest version from the release branch 'master' is automatically deployed to Production environment, [production link](https://zero-waste-project.herokuapp.com/).

## Installation
* Start the project locally
# Required to install
- Ruby 2.7.2
- Ruby on Rails 6.1.3
- PostgreSQL 12
- Puma as a web server
- Yarn
- jQuery
- Bootstrap

## Clone

$ `git clone https://github.com/ita-social-projects/ZeroWaste.git`

## Setup

$ `bin/setup`
or 
$ `bundle install` 

## How to run local

1. Open terminal.
2. Run `rails server` to start application.
3. Open http://localhost:3000 to view it in the browser.
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
