class Twit < ActiveRecord::Base
    belongs_to :user
    scope :user_total_vote, -> { includes(:user).group('users.name').order('sum_vote DESC').sum(:vote) }
    scope :user_total_posts, -> { joins(:user).group('users.name').order('count_users_id DESC').count('users.id') }
    scope :user_top_posts, -> { joins(:user).order('twits.vote DESC').
             select('users.name as user_name, twits.message as message, twits.vote as votes')}

    scope :since_date, ->(date) { where('twits.created_at >= ?', date) }
end
