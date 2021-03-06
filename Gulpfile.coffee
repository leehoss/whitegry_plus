# whitegry_plus gulpfile

gulp = require 'gulp'
sass = require 'gulp-sass'
tar = require 'gulp-tar'
gzip = require 'gulp-gzip'
rename = require 'gulp-rename'
rimraf = require 'rimraf'

gulp.task 'scss', ->
  gulp.src './scss/*.scss'
  .pipe sass(
    outputStyle: 'compressed'
  ).on('error', sass.logError)
  .pipe gulp.dest './css'

gulp.task 'make', ['scss'], ->
  console.log 'Creating rsp package...'
  gulp.src [
    './**/*'
    '!./*.json'
    '!./*.coffee'
    '!./node_modules'
    '!./node_modules/**/*'
    '!./scss/'
    '!./scss/**/*'
  ]
  .pipe tar 'col-whitegry_plus.tar'
  .pipe do gzip
  .pipe gulp.dest '.'
  console.log 'Complete.'

gulp.task 'clean', ->
  rimraf './whitegry_plus.tar.gz'


gulp.task 'default', ['scss']