# Bookmarks
production url: https://kunashir-bookmarks.herokuapp.com/bookmarks
Known problem: sidekiq is not running because Heroku provides Redis v3 but Sidekiq requires 4.

Deploy process (to heroku):

* login into heroku

* run `git push heroku main`

