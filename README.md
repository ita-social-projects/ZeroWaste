<a href="https://softserve.academy/"><img src="https://s.057.ua/section/newsInternalIcon/upload/images/news/icon/000/050/792/vnutr_5ce4f980ef15f.jpg" title="SoftServe IT Academy" alt="SoftServe IT Academy"></a>

# ZERO WASTE

#### [Staging](https://zero-waste-staging.onrender.com/)

# 1. About the project

<img src='logo.jpg' alt='zero-waste'>
Zero Waste Lviv is a Public Organization that works on the implementation of waste reduction principles in Lviv and Ukraine. Organization draws attention of the city and businesses by conducting trainings, meetings, workshops and research to support ‘zero waste’ grounds. Organization conducts a campaign to draw attention to the problem of using disposable hygiene products for women and children and possible ways or reduction. Website - https://zerowastelviv.org.ua

In order to attract attention to financial and ecological consequences of disposable diaper usage it is planned to create a module that will calculate budget spent on diapers and calculations of the future expenses. As visual representation it is planned to show the volume of waste that was made during usage of disposable diapers for one child.

- [Deployed Apps and Environments](#deployed-apps-and-environments)
- [Required to install](#required-to-install)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)

## Deployed Apps and Environments

The latest version from the 'develop' branch is automatically deployed to stage environment in Render, [staging link](https://zero-waste-staging.onrender.com/).
The latest version from the release branch 'master' is automatically deployed to Production environment, [production link](http://calc.zerowastelviv.org.ua/).

## Required to install

- Ruby 3.2.2
- Ruby on Rails 7.1.2
- PostgreSQL 12
- Puma as a web server
- Yarn
- Bootstrap
  
## Installation

 To install ZeroWaste, follow these steps:

<details>
  <summary> <h4>on Windows</h4> </summary>

  First of all you need RVM to setup project. For the operating system Windows the optimal solution is to use <a href="https://docs.microsoft.com/en-us/windows/wsl/">WSL 2</a>.
   
  **1. Clone the repository:**
  
  $ `git clone https://github.com/ita-social-projects/ZeroWaste.git`
  
  **2. Navigate to the project directory:**
  
  $ `cd project-title`
  
  **3. Install the following libraries for image pocessing:**
  
  `sudo apt install imagemagick`
  
  `sudo apt install libvips42`
  
  **4. Install all of a project's dependencies:**
 
  $ `bin/setup`
  or
  $ `bundle install`
  
  **5. Install PostgresSQL**

  To check if PostgreSQL is installed and running correctly run `sudo systemctl status postgresql`
 
  | if PostgreSQL does not install  | if PostgreSQL is instlled but not active | if PostgreSQL is installed and active |
  | ------------- | ------------- | ------------- |
  | Unit postgresql.service could not be found.  | ● postgresql.service - PostgreSQL RDBMS Loaded: loaded (/lib/systemd/system/postgresql.service; enabled) Active: inactive (dead) since [дата і час] Docs: man:postgres(1)  | ● postgresql.service - PostgreSQL RDBMS Loaded: loaded (/lib/systemd/system/postgresql.service; enabled; vendor preset: enabled) Active: active (exited) since [дата і час]Main PID: 426 (code=exited, status=0/SUCCESS) |
  | <a href="https://www.postgresql.org/download/">Install PostgreSQL</a> for your operating system or subsystem. You can familiarize yourself with <a href="https://www.postgresql.org/docs/">PostgreSQL documentation</a>. | run `sudo systemctl start postgresql` | Move to the next step. |
  
  In your local machine in cloned project in config folder rename database.yml.sample to database.yml. Make sure that the user and password match the data in this file. Port may be changed.

  **6. Database configure**

  For further work, make sure that you have a user 'postgres' with proper password. 
  Create database:
  $ `sudo su postgres`
  $ `CREATE DATABASE zero_waste_development;`
  $ `CREATE DATABASE zero_waste_test;`
  
  If you're having trouble authenticating, you may need to reset your password. You can <a href="https://stackoverflow.com/questions/55038942/fatal-password-authentication-failed-for-user-postgres-postgresql-11-with-pg">read</a> instruction how to do it.
  
  To update databases run:

  $ `rake db:migrate`
  
  $ `rake db:reset` can resolve some errors connected with database.
  
  **7. Install Redis**
  
  You need Redis for correct work.
  <a href="https://redis.io/docs/getting-started/">Install Redis</a> for your operating system or subsystem. You can familiarize yourself with
  <a href="https://redis.io/docs//">Redis documentation</a>.

  ```
  curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
  
  echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list
  
  sudo apt-get update
  sudo apt-get install redis
  ```

  Lastly, start the Redis server like so:

  $ `sudo service redis-server start`
  
  To check if it is installed and running correctly run `sudo systemctl status redis-server`

  **8. Install Yarn**
  
  You can read more about yarn there:
  <a href="https://classic.yarnpkg.com/lang/en/docs/">yarn documentation</a>.

  For Windows doqnload the <a href="https://classic.yarnpkg.com/lang/en/docs/install/#windows-stable">yarn installer</a>.
  
  This will give you a .msi file that when run will walk you through installing Yarn on Windows.

  If you use the installer you will first need to install Node.js.
   
 **9. Install Sidekiq**
  
  Simple, efficient background processing for Ruby. You can read more about sidekiq there:
  <a href="https://github.com/mperham/sidekiq">Sidekiq documentation</a>.
  
  Installation:
  $ `bundle add sidekiq`

  **First run**
  
  1. Ensure that postgresql and redis are running
  2. Run `rails assets:precompile` to precompile assets
  3. Run `bin/rails tailwindcss:watch` with `rails server` to watch for changes in tailwind and start server or run `bin/dev`
  4. Open http://localhost:3000 to view it in the browser.
  
  Solutions when an errors occurs:
  <a href="https://stackoverflow.com/questions/15301826/psql-fatal-role-postgres-does-not-exist">psql: FATAL: role "postgres" does not exist</a>
</details>

## Usage

To use ZeroWaste, follow these steps:
1. Run `bin/rails tailwindcss:watch` with `rails server` to watch for changes in tailwind
2. Start server `rails s` or run `bin/dev`
3. Open http://localhost:3000 to view it in the browser.

## Contributing

If you'd like to contribute to ZeroWaste, here are some guidelines:

1. Create a new branch for your changes.
2. Make your changes.
3. Write tests to cover your changes.
4. Run the tests to ensure they pass.
5. Commit your changes.
6. Push your changes to your forked repository.
7. Submit a pull request.

**Before commitying check your code style using [Rubocop](#rubocop)**

**[Git-hoor pre-commit](#git-hook-pre-commit) will run automatically before commit**

### Rubocop

Running rubocop with no arguments will check all Ruby source files in the current folder:

$ `rubocop`

Alternatively you can pass rubocop a list of files and folders to check:

$ `rubocop app spec lib/something.rb`

For more details check the available command-line options:

$ `rubocop -h`

### Git-hook pre-commit

Before using `git-hook-pre-commit` you need to install `sudo apt-get install cmake`

For using `git-hook-pre-commit` type `cp git-hooks/pre-commit .git/hooks/pre-commit` command to install your hook.

Run `git commit -m "name"` to commit changes locally.
If you have some troubles with style conventions after running `git commit -m "name"`, you need to run `rubocop -a` or `rubocop -A`. Each of these commands can resolve the majority of warnings.

Type `git commit -m "name" --no-verify` for commiting without formating.
