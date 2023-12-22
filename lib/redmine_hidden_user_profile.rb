module RedmineHiddenUserProfile
  class << self
    def setup
      WatchersHelper.send(:include, RedmineHiddenUserProfile::Patches::WatchersHelperPatch)
      ApplicationHelper.send(:include, RedmineHiddenUserProfile::Patches::ApplicationHelperPatch)
    end
  end
end
