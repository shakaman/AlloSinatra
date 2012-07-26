# encoding: utf-8

# gems
require 'sinatra/base'
require 'sinatra/json'
require 'open3'

module AlloSinatra
  class App < Sinatra::Base
    register Kaminari::Helpers::SinatraHelpers
    helpers Sinatra::JSON

    set :public_folder, File.expand_path('public', AlloSinatra.root)
    set :views,         File.expand_path('views', AlloSinatra.root)


    # Return list of confcalls
    get '/confcalls' do
      confcall = Confcall.page(params[:page])
      confcall.to_json
    end

    # Create a new confcall
    post '/confcalls' do
      p params[:confcall]
      confcall = Confcall.new(params[:confcall])
      p confcall
      if confcall.save
        start_conf_conf(confcall)
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

    helpers do
      def command_to_json(command)
        stdin, stdout, stderr, wait_thr = Open3.popen3(command)
        json command: command, stdout: stdout.readlines, stderr: stderr.readlines
      end
    end

    # 404
    not_found do
      #haml :not_found, :format => :html5, :layout => :layout
    end

    private

    def init_linphone
      p 'init'
      command = "linphonecsh init -c config/linphonerc"
      Open3.popen3(command)

      active_record
    end

    def active_record
      p 'active record'
      command = "linphonecsh generic 'soundcard use files'"
      Open3.popen3(command)
    end

    def start_conf_conf(confcall)
      init_linphone
      command = "linphonecsh dial #{confcall[:phone]}"
      Open3.popen3(command)
    end

  end
end
