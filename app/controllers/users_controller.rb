require 'redmine'
require_dependency 'users_controller'

class UsersController < ApplicationController
  layout 'admin'
  before_filter :find_user, :check_hidden_permission, :only => [:show]
  accept_api_auth :index, :show, :create, :update, :destroy

    helper :sort
    include SortHelper
    helper :custom_fields
    include CustomFieldsHelper

  def check_hidden_permission
     if !User.current.admin && User.current.allowed_to?(:view_profiles, @project, :global => true).nil?
         render_403
     end
  end
end
