# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

user = User.create!(:email => "t2@123.com", 
  :password => "password", :password_confirmation => "password")
user.confirmed_at = Time.now 
user.save

user = User.create!(:email => "admin@123.com",
  :password => "password", :password_confirmation => "password", 
  :is_admin => true )
user.confirmed_at = Time.now   
user.save

job = Job.create!( :title => "收银员", :url => "", 
                   :company_name => "欧尚", :job_type => "兼职", 
                   :occupation => "其它",
                   :location => "宁波海曙", :user_id => 2,
                   :description => "有收银员经历的优先", 
                   :apply_information => "请发邮件给我们" )
