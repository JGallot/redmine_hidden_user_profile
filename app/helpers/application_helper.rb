require 'redmine'
require_dependency 'application_helper'
require 'forwardable'
require 'cgi'

module ApplicationHelper
  include Redmine::WikiFormatting::Macros::Definitions
  include Redmine::I18n
  include GravatarHelper::PublicMethods

  include Redmine::Pagination::Helper
  include Redmine::SudoMode::Helper
  include Redmine::Themes::Helper
  include Redmine::Hook::Helper
  include Redmine::Helpers::URL


  extend Forwardable
  def_delegators :wiki_helper, :wikitoolbar_for, :heads_for_wiki_formatter

  # Displays a link to user's account page if active
    def link_to_user(user, options={})
      if (User.current.admin || User.current.allowed_to?(:view_profiles, @project, :global => true)) && user.is_a?(User)
        name = h(user.name(options[:format]))
        if user.active?
          user.is_a?(User) ? link_to_principal(user, options) : h(user.to_s)
        else
          name
        end
      else
        h(user.to_s)
      end
    end
end
