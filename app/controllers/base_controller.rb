class BaseController < ApplicationController
  load_and_authorize_resource :except => :create

  PER_PAGE = 20
end
