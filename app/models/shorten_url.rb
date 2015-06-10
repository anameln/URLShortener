class ShortenUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true
  belongs_to :submitter,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id

  has_many :visits,
    class_name: "Visit",
    foreign_key: :visited_url_id,
    primary_key: :id

  has_many :visitors, Proc.new { distinct }, through: :visits, source: :visitor

  has_many :topics
    class_name: "Tagging",
    foreign_key: :tag_topic_id,
    primary_key: :id

  has_many :tag_topics, through: :topics, source: :tag_topic

  def self.random_code
    code = nil

    loop do
      code = SecureRandom.urlsafe_base64
      break unless ShortenUrl.exists?(short_url: code)
    end

    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    short = random_code
    new_row = ShortenUrl.new(long_url: long_url,
                   short_url: short,
                   submitter_id: user.id)
    new_row.save!

    short
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    #Visit.select('visitor_id').distinct.where(visited_url_id: id).count
    visitors.count
  end

  def num_recent_uniques
    Visit.select('visitor_id').distinct.where(visited_url_id: id)
    .where(created_at: (10.minutes.ago..Time.now)).count
  end

end
