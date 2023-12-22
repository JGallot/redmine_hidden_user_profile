# frozen_string_literal: true

module RedmineHiddenUserProfile
  module Patches
    module ApplicationHelperPatch
      extend ActiveSupport::Concern

      included do
        include InstanceMethods

        alias_method :format_object_without_hidden_user, :format_object
        alias_method :format_object, :format_object_with_hidden_user

      end

      module InstanceMethods
        def format_object_with_hidden_user(object, html = true, &block)
            if block_given?
              object = yield object
            end
            case object.class.name
            when 'User', 'Group'
              if User.current.admin || ((User.current.allowed_to?(:view_profiles, @project)) )
                html ? link_to_principal(object) : object.to_s
              else
                object.to_s
              end
            else
              format_object_without_hidden_user object, html, &block
            end
          end
      end
    end
  end
end