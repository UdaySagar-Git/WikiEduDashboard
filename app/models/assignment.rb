# == Schema Information
#
# Table name: assignments
#
#  id            :integer          not null, primary key
#  created_at    :datetime
#  updated_at    :datetime
#  user_id       :integer
#  course_id     :integer
#  article_id    :integer
#  article_title :string(255)
#  role          :integer
#

#= Assignment model
class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  belongs_to :article

  scope :assigned, -> { where(role: 0) }
  scope :reviewing, -> { where(role: 1) }

  ####################
  # CONSTANTS        #
  ####################
  module Roles
    ASSIGNED_ROLE  = 0
    REVIEWING_ROLE = 1
  end

  def page_url
    language = ENV['wiki_language']
    escaped_title = article_title.tr(' ', '_')
    "https://#{language}.wikipedia.org/wiki/#{escaped_title}"
  end
end
