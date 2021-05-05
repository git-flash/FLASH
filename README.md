# FLASH

This is a member attendance and event tracker for FLASH.

This project can be run in docker with the up.bash/up.bat file.

## Running Local
- Install Docker and docker-compose
  - https://docs.docker.com/get-docker/
  - https://docs.docker.com/compose/install/ (if on Linux/Not installed with docker)
- Clone project
  - `git clone https://github.com/git-flash/FLASH.git`
- Run `./up.bash` in Linux/MacOS or `up.bat` in Windows
  - On Windows ensure `entrypoint.sh` has LF line endings
- All gems are auto-installed by docker
- Ruby is auto-installed by docker
- Database is set up automatically by docker
- Local will run on [`localhost:3000`](http://localhost:3000)
- Stop the sever by sending a termination (`Ctrl+C` in the terminal)
- Every launch will initialize a new database adn reflect all ruby changes
  - If a new database is not needed run `docker-compose up` instead of the `up.bash`/`up.bat` script

## Deployment
- Manual deployment can be accomplished through the heroku command line interface
  1. https://devcenter.heroku.com/articles/getting-started-with-rails6#deploy-your-application-to-heroku
     - Do all the deployment steps up to and including database migration
  2. Afterwards, make sure to run `heroku run rake db:seed` on the deployed app to get the initial users
  3. Add the config variable `GMAIL_PASSWORD` and set it to the password of `tamuflashpoint@gmail.com`
- Automatic deployment can be set up using heroku's github integration (details below)
  - https://devcenter.heroku.com/articles/github-integration

## Github Actions setup
- Rubocop and brakeman are run daily at 8am and on every push/pull request to `dev` and `master` branches.
- `dev` branch will automatically deploy to [flashpoint8](https://flashpoint8.herokuapp.com/)
- `master` branch will automatically deploy to [flash-point](https://flash-point.herokuapp.com/)
- CI/CD is automatically set up when `.github/workflows` has files added

## CI/CD Details
- The application implements CI/CD using GitHub Actions (More details above) and Heroku as its main tools. 

- Continous Integration (CI)
 - CI is done using Github Actions. The workflow in the .github folder runs under if the following situations occurs
  - Daily at 8 AM
  - Every Push/Pull request to `dev `
  - Every Push/Pull request to `master`
- The workflow in the .github folder runs the following tests: Brakeman and Rubocop
- You can find the results of these tests in the Actions tab on GitHub once they have run

- Continous Develpoment (CD)
 - Heroku was the main tool for CD 
  - Heroku builds and deploys all pushes
  - Heroku will wait for the CI to pass before depolyment
  - Pipeline (Heroku will use this for CD):
    - Create a new Pipeline
    - Connect this Pipeline to Github 
    - Enable the Automatic Deployment of a particular branch when pull requests are made
    - Additional information can be found here: https://devcenter.heroku.com/articles/pipelinesgit s