class Post < ActiveRecord::Base
  belongs_to :user
  has_many :likes
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :default_url => "blank.jpg",
                    :storage => :s3,
                    :s3_credentials => Proc.new{|a| a.instance.s3_credentials }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def s3_credentials
    {:bucket => "slugstagram", :access_key_id => ENV["ACCESS_KEY_ID"], :secret_access_key => ENV["SECRET_ACCESS_KEY"]}
  end
end
