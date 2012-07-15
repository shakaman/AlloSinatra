# encoding: utf-8

require 'sinatra/base'
require 'sinatra/json'
require 'open3'

class AlloSinatra < Sinatra::Base
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
    command = "linphonecsh generic 'record file'"
    stdin, stdout, stderr = Open3.popen3(command)
    json command: command, stdout: stdout.readlines, stderr: stderr.readlines
  end
end

AlloSinatra.run!
