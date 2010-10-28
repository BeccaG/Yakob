class User < ActiveRecord::Base
  has_and_belongs_to_many :roles
  devise :database_authenticatable, :token_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  default_scope :conditions => { :deleted_at => nil }
  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false, :scope => :deleted_at
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  has_friendly_id :name, :use_slug => true, :strip_non_ascii => true

  
  def role?(role)
    return !!self.roles.find_by_name( Role.sanitize role )
  end

def destroy
    self.update_attribute(:deleted_at, Time.now.utc)
  end

  def self.find_with_destroyed *args
    self.with_exclusive_scope { find(*args) }
  end

  def self.find_only_destroyed
    self.with_exclusive_scope :find => { :conditions => "deleted_at IS NOT NULL" } do
      all
    end
  end

end
