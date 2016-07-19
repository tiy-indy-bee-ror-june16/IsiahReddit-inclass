class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :link
  after_save :calc_vote_score



  private

  def calc_vote_score
    link.vote_score = link.votes.sum('value')
    if link.vote_score == nil
      link.vote_score = 0
    end
    link.save!
  end

end
