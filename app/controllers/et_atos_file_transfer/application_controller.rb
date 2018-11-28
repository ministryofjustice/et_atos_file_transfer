module EtAtosFileTransfer
  class ApplicationController < ActionController::API
    # protect_from_forgery with: :exception
    include ActionView::Rendering

    def external_system
      request.env['et_atos_file_transfer.external_system']
    end
  end
end
