require 'openssl'
require 'open-uri'

class GithubController < ApplicationController

  def statusboard

    # github = Github.new do |config|
    #   config.endpoint    = 'https://github.company.com/api/v3'
    #   config.site        = 'https://github.company.com'
    #   config.oauth_token = '2289fa1f5eb0195a6d631b023ecf2e41d9d388d6'
    #   config.user        = 'rymanalo'
    #   config.adapter     = :net_http
    #   config.ssl         = {:verify => false}
    # end
    # github = Github.new oauth_token: '2289fa1f5eb0195a6d631b023ecf2e41d9d388d6'

    # repos = github.repos.commits.all  'rymanalo', 'music_search'

    # file = open('https://api.github.com/users/rymanalo/repos')
    # repos = JSON.load(file.read)


    client = Octokit::Client.new(:login => "me", :oauth_token => ENV['GITHUB_TOKEN'])
    repos = client.repositories("rymanalo")
    repo_names = repos.map {|repo| repo['name']}
    # user2 = Octokit.repo("rymanalo/music_search")



    repo_commits = repo_names.map do |name|
      "#{name}: #{client.list_commits("rymanalo/#{name}").count}"
    end

    render :json => repo_commits
  end

end
