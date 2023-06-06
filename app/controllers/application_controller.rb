class ApplicationController < ActionController::API
  include SerializationConcern
  include SessionConcern
end
