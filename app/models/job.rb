# encoding: utf-8
class Job < ActiveRecord::Base
  
  attr_accessor :deadline_forever
  
  extend Searchable
  searchable_by :title, :job_type, :occupation, :company_name, :url, :location, :description, :apply_information
  
  validates_presence_of :title
  validates_presence_of :job_type
  validates_presence_of :company_name
  validates_presence_of :occupation
  validates_presence_of :location
  validates_presence_of :description
  validates_presence_of :apply_information
  validates_presence_of :owner

  JOB_TYPE = ['兼职', '服务外包', '社会实践', '其它']
  OCCUPATION = ['社会服务', '系统开发', '系统维护', '其它']
  
  validates_inclusion_of :job_type, :in => JOB_TYPE 
  validates_inclusion_of :occupation, :in => OCCUPATION

  belongs_to :owner, :class_name => "User",:foreign_key => "user_id"

  before_validation :set_aasm_state, :on => :create
  before_validation :set_deadline
  
  scope :published , where(:aasm_state => "published")
  scope :online, published.where("deadline is NULL or deadline > ?", Date.today )
  
  def open
    self.aasm_state = "published"
  end
  
  def close
    self.aasm_state = "closed"
  end
  
  def closed?
    self.aasm_state == "closed"
  end
  
  def to_param
    "#{self.id}-#{self.title} #{self.company_name}".to_slug.normalize.to_s
  end
  
  def social_link_url
    CGI::escape "http://jobs/#{self.to_param}"
  end
  
  def social_link_title
    CGI::escape self.title
  end
  
  def social_link_content
    "#{social_link_title} #{social_link_url}"
  end
  
  def deadline_forever
    @deadline_forever ||= !self.deadline
  end
  
  private
  
  def set_deadline
    self.deadline = nil if self.deadline_forever == "1"
  end
     
  def set_aasm_state
    self.aasm_state = "published"
  end
  
end
