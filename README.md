# AlloSinatra
=============

Simple API to record confcall by sip, use [linphone](http://www.linphone.org/)

## Installatoon
### Install and configure linphone
 * `sudo apt-get install linphone`
 * use GUI interface to configure sip account

### Configure AlloSinatra
 * `cp ~/.linphonerc .`
 * `cp config/development.yml.example config/development.yml`
 * `cp config/mongoid.yml.example config/mongoid.yml`

### Install and launch API
 * `gem install bundler`
 * `bundle install`
 * `shotgun thin config/allosinatra.ru`


## Routes
 * `GET     /confcalls`
 * `POST    /confcalls`
 * `PUT     /confcalls/:id`
 * `GET     /confcalls/:id`
 * `DELETE  /confcalls/:id`

## Linphonecsh
### Command lines
 * initialize: `linphonecsh init -c config/linphonerc`
 * exit: `linphonecsh exit`
 * status: `linphonecsh generic 'status register'`
 * calls: `linphonecsh generic 'calls'`
 * dial: `linphonecsh dial #{number}"`
 * hangup: `linphonecsh hangup`
 * record/start: `linphonecsh generic 'record #{file}'"`

##Credits
♡2012 by Maxim Bénadon. Copying is an act of love. Please copy and share.
