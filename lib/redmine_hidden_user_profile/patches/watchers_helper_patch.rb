module RedmineHiddenUserProfile
  module Patches
    module WatchersHelperPatch
      def self.included(base)
        base.extend(ClassMethods)
        base.send(:prepend, InstanceMethods)
        base.class_eval do
          def hide_user_watchers_list(object)
            remove_allowed = User.current.allowed_to?("delete_#{object.class.name.underscore}_watchers".to_sym, object.project)
            content = ''.html_safe
            lis = object.watcher_users.collect do |user|
              s = ''.html_safe
              s << avatar(user, :size => "16").to_s
              if User.current.admin || User.current.allowed_to?(:view_profiles, @project)
                s << link_to_principal(user, class: user.class.to_s.downcase)
              else
                s << content_tag('span',user, class: user.class.to_s.downcase)
              end
              if object.respond_to?(:visible?) && user.is_a?(User) && !object.visible?(user)
                s << content_tag('span', l(:notice_invalid_watcher), class: 'icon-only icon-warning', title: l(:notice_invalid_watcher))
              end
              if remove_allowed
                url = {:controller => 'watchers',
                       :action => 'destroy',
                       :object_type => object.class.to_s.underscore,
                       :object_id => object.id,
                       :user_id => user}
                s << ' '
                s << link_to(l(:button_delete), url,
                             :remote => true, :method => 'delete',
                             :class => "delete icon-only icon-del",
                             :title => l(:button_delete))
              end
              content << content_tag('li', s, :class => "user-#{user.id}")
            end
            content.present? ? content_tag('ul', content, :class => 'watchers') : content
          end
        end
      end
      module InstanceMethods

      end #module

      module ClassMethods

      end #module

    end
  end
end