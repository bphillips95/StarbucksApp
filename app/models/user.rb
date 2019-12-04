class User < ActiveRecord::Base
    has_many :orders 
    has_many :starbucks, through: :orders
    
    def self.tty_prompt
        TTY::Prompt.new 
    end 
   
    def self.log_in
        choice = self.tty_prompt.select("Would you like to do") do |menu|
            menu.choice "Log in", -> {User.handle_existing_user}
            menu.choice "Sign up", -> {User.handle_new_user}
            #user_man = User.all.last <---why do we need thi?
        end 
    end 


    def self.handle_existing_user 
        system "clear"
        username = self.tty_prompt.ask('What is your username?') do |a|
            a.required true
        end
        if User.all.map(&:username).exclude?(username)
            puts 'This username does not exist'
            sleep 5 / 2
            system "clear"
            puts 'Please create a new account'
            sleep 2
            self.handle_new_user 
        else
            username
        end
    end

    def self.handle_new_user 
        # able to create empty username and password 
        system "clear" 
        username = self.tty_prompt.ask("Create a username") 
        # username = username.downcase
        if User.all.map(&:username).include?(username)
            puts 'This username already exist'
            sleep 5 / 2
            system "clear"
            puts 'Please enter a new username'
            sleep 1
            # self.handle_new_user 
            self.log_in
        else
            password = self.tty_prompt.mask("Create a password") 
        end   
        User.create(username: username, password: password)
    end 

end