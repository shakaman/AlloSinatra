# encoding: utf-8

# gems
require 'sinatra/base'
require 'sinatra/json'
require 'open3'

module AlloSinatra
  class App < Sinatra::Base
    helpers Sinatra::JSON

    get '/init' do
      command = "linphonecsh init -c config/linphonerc"
      stdin, stdout, stderr = Open3.popen3(command)
      json command: command, stdout: stdout.readlines, stderr: stderr.readlines
    end

    get '/exit' do
      command = "linphonecsh exit"
      stdin, stdout, stderr = Open3.popen3(command)
      json command: command, stdout: stdout.readlines, stderr: stderr.readlines
    end

    get '/status' do
      command = "linphonecsh generic 'status register'"
      stdin, stdout, stderr = Open3.popen3(command)
      json command: command, stdout: stdout.readlines, stderr: stderr.readlines
    end

    get '/calls' do
      command = "linphonecsh generic 'calls'"
      stdin, stdout, stderr = Open3.popen3(command)
      json command: command, stdout: stdout.readlines, stderr: stderr.readlines
    end

    get '/call/dial/:number' do
      active_record
      command = "linphonecsh dial #{params[:number]}"
      stdin, stdout, stderr = Open3.popen3(command)
      json command: command, stdout: stdout.readlines, stderr: stderr.readlines
    end

    get '/call/hangup' do
      command = "linphonecsh hangup"
      stdin, stdout, stderr = Open3.popen3(command)
      json command: command, stdout: stdout.readlines, stderr: stderr.readlines
    end

    get '/call/record/start' do
      file = '/home/shakaman/test.wav'
      command = "linphonecsh generic 'record #{file}'"
      stdin, stdout, stderr = Open3.popen3(command)
      json command: command, stdout: stdout.readlines, stderr: stderr.readlines
    end

    def active_record
      command = "linphonecsh generic 'soundcard use files'"
      Open3.popen3(command)
    end


    # register after redefinition of signup
    #register Sinatra::SinatraAuthentication

    # 404
    not_found do
      #haml :not_found, :format => :html5, :layout => :layout
    end

  end
end
