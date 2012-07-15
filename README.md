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
 * `./bin/allo_sinatra`


## Routes
 * `/init`
 * `/exit`
 * `/status`
 * `/calls`
 * `/call/dial/:number`
 * `/call/hangup`
 * `/call/record/start`


##Credits
♡2012 by Maxim Bénadon. Copying is an act of love. Please copy and share.
