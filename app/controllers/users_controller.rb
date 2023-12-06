require 'redmine'
require_dependency 'users_controller'

class UsersController < ApplicationController
  layout 'admin'
  self.main_menu = false

  before_action :find_user, :check_hidden_permission, :only => [:show]
  accept_api_auth :index, :show, :create, :update, :destroy


  helper :sort
  include SortHelper
  helper :custom_fields
  include CustomFieldsHelper

  def check_hidden_permission
    if !User.current.admin && !User.current.allowed_to?(:view_profiles, @project, :global => true)
       Rails.logger.info "###############################"
       @project = nil
       render_error({:message => l(:label_hidden_profile_unauthorized_access), :status => 403})
    end
  end
end
