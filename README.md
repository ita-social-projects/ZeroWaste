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

The latest version from the 'develop' branch is automatically deployed to stage environment in Render, [staging link](http://51.44.25.104/en).
The latest version from the release branch 'master' is automatically deployed to Production environment, [production link](http://calc.zerowastelviv.org.ua/).

## Required to install

- Ruby 3.3.5
- Ruby on Rails 7.1.2
- PostgreSQL 12
- Puma as a web server
- Yarn
- Bootstrap

## Installation

## Clone

$ `git clone https://github.com/ita-social-projects/ZeroWaste.git`

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

  | Status  | Next step |
  | ------------- | ------------- |
  | Not installed  | <a href="https://www.postgresql.org/download/">Install PostgreSQL</a> for your operating system or subsystem. You can familiarize yourself with <a href="https://www.postgresql.org/docs/">PostgreSQL documentation</a>.|
  | Installed but inactive | Start PostgreSQL `sudo systemctl start postgresql` |
  | Installed and avtive | Move to the next step. |

  **6. Database configure**

  In your local machine in cloned project in config folder rename database.yml.sample to database.yml. Make sure that the user and password match the data in this file. Port may be changed.

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

**Access the application**
 Open http://localhost:3000 to view it in the browser.

  Solutions when an errors occurs:
  <a href="https://stackoverflow.com/questions/15301826/psql-fatal-role-postgres-does-not-exist">psql: FATAL: role "postgres" does not exist</a>
</details>

<details>
  <summary> <h4>Linux</h4> </summary>
  First, ensure RVM is installed for Ruby management. You can install RVM by following the official RVM installation guide. Make sure to follow any instructions for setting up your shell.

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

  Ensure PostgreSQL is installed and active:

  ```
  sudo apt update
  sudo apt install postgresql postgresql-contrib
  ```

  To check if PostgreSQL is running: `sudo systemctl status postgresql`

  | Status  | Next step |
  | ------------- | ------------- |
  | Not installed  | <a href="https://www.postgresql.org/download/">Install PostgreSQL</a> for your operating system or subsystem. You can familiarize yourself with <a href="https://www.postgresql.org/docs/">PostgreSQL documentation</a>.|
  | Installed but inactive | Start PostgreSQL `sudo systemctl start postgresql` |
  | Installed and avtive | Move to the next step. |

  **6. Database configuration**

  In the config folder, rename database.yml.sample to database.yml. Update it with your PostgreSQL username and password, and adjust the port if necessary.

  To set up the database:

  ```
  sudo -u postgres psql -c "CREATE DATABASE zero_waste_development;"
  sudo -u postgres psql -c "CREATE DATABASE zero_waste_test;"
  ```

   If you're having trouble authenticating, you may need to reset your password. You can <a href="https://stackoverflow.com/questions/55038942/fatal-password-authentication-failed-for-user-postgres-postgresql-11-with-pg">read</a> instruction how to do it.

  Run Database migrations:

  $ `rake db:migrate`

  If issues arise, reset the database:

  $ `rake db:reset`

  **7. Install Redis**

  Install Redis for background job processing:
  <a href="https://redis.io/docs/getting-started/">Install Redis</a> for your operating system or subsystem. You can familiarize yourself with
  <a href="https://redis.io/docs//">Redis documentation</a>.

  ```
  sudo apt update
  sudo apt install redis
  ```

  Start the Redis server:

  $ `sudo service redis-server start`

  Verify Redis is active `sudo systemctl status redis-server`

  **8. Install Yarn**

  You can read more about yarn there:
  <a href="https://classic.yarnpkg.com/lang/en/docs/">yarn documentation</a>.

 **9. Install Sidekiq**

  Sidekiq handles background processing in Ruby. Install it with:
  <a href="https://github.com/mperham/sidekiq">Sidekiq documentation</a>.

  Installation:

  $ `bundle add sidekiq`

  **First run**

    1. Confirm PostgreSQL and Redis are running.
    2. Run `rails assets:precompile` to precompile assets
    3. Run `bin/rails tailwindcss:watch` with `rails server` to watch for changes in tailwind and start server or run `bin/dev`

  **Access the application**
 Open http://localhost:3000 to view ZeroWaste in the browser.

  Solutions when an errors occurs:
  <a href="https://stackoverflow.com/questions/15301826/psql-fatal-role-postgres-does-not-exist">psql: FATAL: role "postgres" does not exist</a>
</details>

<details>
  <summary> <h4>macOS</h4> </summary>

  First, ensure RVM is installed for Ruby management. You can install RVM by following the official RVM installation guide. Make sure to follow any instructions for setting up your shell.

 **1. Clone the repository:**

  $ `git clone https://github.com/ita-social-projects/ZeroWaste.git`

  **2. Navigate to the project directory:**

  $ `cd project-title`

  **3. Install the following libraries for image pocessing:**

  `brew install imagemagick`

  `brew install libvips42`

  **4. Install all of a project's dependencies:**

  $ `bin/setup`
  or
  $ `bundle install`

  **5. Install PostgresSQL**

  Ensure PostgreSQL is installed and active:

  ```
  brew install postgresql
  ```

  After installation, start PostgreSQL: `brew services start postgresql`

  **6. Database configuration**

  In the config folder, rename database.yml.sample to database.yml.

  Update it with your PostgreSQL username and password, and adjust the port if necessary.

  ```
  psql -U postgres
  CREATE DATABASE zero_waste_development;
  CREATE DATABASE zero_waste_test;
  \q
  ```

   If you're having trouble authenticating, you may need to reset your password. You can <a href="https://stackoverflow.com/questions/55038942/fatal-password-authentication-failed-for-user-postgres-postgresql-11-with-pg">read</a> instruction how to do it.

  Run Database migrations:

  $ `rake db:migrate`

  If issues arise, reset the database:

  $ `rake db:reset`

  **7. Install Redis**

  Install Redis for background tasks processing:
  <a href="https://redis.io/docs/getting-started/">Install Redis</a> for your operating system or subsystem. You can familiarize yourself with
  <a href="https://redis.io/docs//">Redis documentation</a>.

  ```
  brew install redis
  ```

  Start the Redis service:

  $ `brew services start redis`

  **8. Install Yarn**

  You can read more about yarn there:
  <a href="https://classic.yarnpkg.com/lang/en/docs/">yarn documentation</a>.

  Install Yarn using Homebrew. You may need Node.js as well if it’s not installed.

  `brew install yarn`

 **9. Install Sidekiq**

  Sidekiq handles background processing in Ruby. Install it with:
  <a href="https://github.com/mperham/sidekiq">Sidekiq documentation</a>.

  Installation:

  $ `bundle add sidekiq`

**First run**

  1. Confirm PostgreSQL and Redis are running.
  2. Run `rails assets:precompile` to precompile assets
  3. Run `bin/rails tailwindcss:watch` with `rails server` to watch for changes in tailwind and start server or run `bin/dev`

**Access the application**
 Open http://localhost:3000 to view ZeroWaste in the browser.

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
