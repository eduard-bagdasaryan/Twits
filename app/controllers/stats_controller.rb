class StatsController < ApplicationController

  def index

     d = since_date

     @top_rated = User.select("users.name as user_name, sum(twits.vote) as total_vote").
         joins(:twits).
         group("users.name").
         order("total_vote DESC").
         where("twits.created_at >= ?", d).
         first(5)

     @top_posters = User.select("users.name as user_name, count(users.id) as posts_count").
         joins(:twits).
         group("users.name").
         order("posts_count DESC").
         where("twits.created_at >= ?", d).
         first(5)

     @top_posts = User.select("users.name as user_name, twits.message as message, twits.vote as votes").
         joins(:twits).
         order("twits.vote DESC").
         where("twits.created_at >= ?", d).
         first(5)
  end

  private

  def since_date
      d = 10.years.ago
      if params[:date] == 'today'
          d = Date.today.at_beginning_of_day
      elsif params[:date] == 'this_week'
          d = Date.today.at_beginning_of_week
      end
     return d;
  end

end
