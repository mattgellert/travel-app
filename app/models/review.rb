class Review < ApplicationRecord
  belongs_to :trip
  belongs_to :reviewer, class_name: "User", foreign_key: :user_id

  def vote=(vote)
    self.review.vote ||= 0
    if vote == "upvote"
      self.review.vote += 1
    elsif vote == "downvote"
      self.review.vote -= 1
    else
      self.review.vote += 0
    end
  end

  def vote
    if self.vote
      self.vote < 0 ? 0 : self.vote
    end
  end
end
