namespace :alcoholic do

  desc  "sync google contacts"
  task :google_contacts => :environment do
    puts "here i'll sync the google contacts based on the username's profile infomation"
     Contacts::Google.authentication_url('http://lorgiojimenez.com/')     
     gmail = Contacts::Google.new(user.email_address, params[:token])
     # gmail = Contacts::Google.new('lorgiojimenez.@gmail.com', 'CNPdkJCHDRCXm9WTAw')
     contacts = gmail.contacts
  end

end