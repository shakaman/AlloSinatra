# encoding: utf-8

# gems
require 'sinatra/base'
require 'sinatra/json'
require 'open3'

module AlloSinatra
  class App < Sinatra::Base
    register Kaminari::Helpers::SinatraHelpers
    helpers Sinatra::JSON
    set :public_folder, Proc.new { File.join(root, '..', '..', 'public') }

    # Return list of confcalls
    get '/confcalls' do
      confcall = Confcall.page(params[:page])
      confcall.to_json
    end

    # Create a new confcall
    post '/confcalls' do
      confcall = Confcall.new(params[:confcall])
      if confcall.save
        confcall.to_json
      else
        halt '400'
      end
    end

    # Update a confcall
    put '/confcalls/:id' do
      confcall = Confcall.find(params[:id])
      if confcall.update_attributes(params[:confcall])
        confcall.to_json
      else
        halt '400'
      end
    end

    # Show a confcall
    get '/confcalls/:id' do
      Confcall.find(params[:id]).to_json
    end

    # Delete a confcall
    delete '/confcalls/:id' do
      confcall = Confcall.find(params[:id])
      if confcall.destroy
        halt '200'
      else
        halt '404'
      end
    end




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
      file = File.join(settings.public_folder, 'test.wav')
      command = "linphonecsh generic 'record #{file}'"
      stdin, stdout, stderr = Open3.popen3(command)
      json command: command, stdout: stdout.readlines, stderr: stderr.readlines
    end

    def active_record
      command = "linphonecsh generic 'soundcard use files'"
      Open3.popen3(command)
    end

    # 404
    not_found do
      #haml :not_found, :format => :html5, :layout => :layout
    end

  end
end
