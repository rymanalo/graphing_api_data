class GithubController < ApplicationController

  def statusboard


    client = Octokit::Client.new(:login => "me", :oauth_token => ENV['GITHUB_TOKEN'])
    repos = client.repositories("rymanalo")
    repo_names = repos.map {|repo| repo['name']}

    repo_commits = repo_names.map do |name|
      client.commits("rymanalo/#{name}").map do |sha|
        (sha['commit']['author']['date']).gsub(/(\A\d*-\d*-\d*)T\d*:\d*:\d*Z/, "\\1")
      end
    end

    commits = repo_commits.flatten.sort
    unique_days = commits.uniq

    commits_per_day = unique_days.map do |day|
      {"title" => day, "value" => (commits.select {|commit| commit == day}).count}
    end

    response = {graph: {
      title: "Commits per Day",
      xAxis: {showEveryLabel: true},
      type: "line",
      color: "blue",
      refreshEveryNSeconds: 10,
      datasequences: [
        { title: "Daily Commits",
          datapoints: commits_per_day}]
      }}


    render :json => response
  end

end