require 'redmine'

Redmine::Plugin.register :redmine_hidden_user_profile do
  requires_redmine version_or_higher: '5.0.0'
  name 'Redmine Hidden User Profile plugin'
  author 'Jérôme GALLOT (based on Monika Perwejnis work)'
  description 'Add permission to view user profile, hide members box in projects, Link to user is a string. Member profile page is not available - 403.'
  version '0.0.2'
  author_url 'https://github.com/JGallot'

  permission :view_profiles, :user => :show
end


