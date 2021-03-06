# encoding: UTF-8
# user twits and statistics
class Twit < ActiveRecord::Base
  belongs_to :user

  validates :message, :user, presence: true

  scope :user_total_vote, lambda {
    includes(:user).group('users.name')
      .order('sum_vote DESC').sum(:vote)
  }
  scope :user_total_posts, lambda {
    joins(:user).group('users.name')
      .order('count_users_id DESC').count('users.id')
  }
  scope :user_top_posts, lambda {
    joins(:user).order('twits.vote DESC')
      .select('users.name as user_name, twits.message as message,
             twits.vote as votes')
  }

  scope :since_date, ->(date) { where('twits.created_at >= ?', date) }
  scope :twits_all, -> { joins(:user).select('users.name, twits.*') }
end
