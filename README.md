# FLASH

This is a member attendance and event tracker for FLASH.

This project can be run in docker with the up.bash/up.bat file.


## Running Local
- Install Docker
- Run `./up.bash` in Linux/MacOS or `up.bat` in Windows

## Github Actions setup
- Rubocop and brakeman are run daily at 8am and on every push/pull request to `dev` and `master` branches.
- `dev` branch will automatically deploy to [flashpoint8](https://flashpoint8.herokuapp.com/)
- `master` branch will automatically deploy to [flash-point](https://flash-point.herokuapp.com/)
