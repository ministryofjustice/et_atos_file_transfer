EtAtosFileTransfer::Engine.routes.draw do
  constraints EtAtosFileTransfer::BasicConstraint do
    namespace :v1, path: '/' do
      get '/list' => 'file_transfers#index', defaults: { format: 'text' }
      post '/delete' => 'file_transfers#delete', defaults: { format: 'text' }
      post '/upload' => 'file_transfers#upload', defaults: { format: 'text' }
      get '/test' => 'test#show', defaults: { format: 'text' }
      get '/download/*filename' => 'file_transfers#download', format: false

    end
  end
  get '/ping' => 'status#ping'
  get '/healthcheck' => 'status#healthcheck'
end
