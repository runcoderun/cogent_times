class UsersController < ApplicationController
  resources_controller_for :users
  
  def create
    require 'pp'
    pp params
    super
  end
  
end
