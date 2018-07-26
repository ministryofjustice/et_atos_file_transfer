Rails.application.routes.draw do
  mount EtAtosFileTransfer::Engine => "/"
end
