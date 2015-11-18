# encoding: UTF-8

# stats controller
class StatsController < ApplicationController
  def index
    d = since_date
    @top_rated = Twit.since_date(d).user_total_vote.first(5)
    @top_posters = Twit.since_date(d).user_total_posts.first(5)
    @top_posts = Twit.since_date(d).user_top_posts.first(5)
  end

  private

  def since_date
    if params[:date] == 'today'
      d = Date.today.at_beginning_of_day
    elsif params[:date] == 'this_week'
      d = Date.today.at_beginning_of_week
    end
    d || 10.years.ago
  end
end
