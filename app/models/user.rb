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
        end 
    end 

    def self.find_byp_username(uname)
        User.all.find do |user|
            if user.username == uname 
                @a = "#{user.password}"
            end
        end
        @a
    end 

    def self.find_idby_username(uname)
        User.all.find do |user|
            if user.username == uname 
                user 
            end
        end
    end

    def self.handle_existing_user 
        system "clear"
        username = self.tty_prompt.ask('Enter your username: ', required: true)
        if User.all.map(&:username).exclude?(username)
            puts 'This username does not exist'
            sleep 5 / 2
            system "clear"
            puts 'Please create a new account'
            sleep 2
            self.log_in
        else
            p = self.tty_prompt.mask('Enter your password:', required: true)
            if  self.find_byp_username(username) == p
                puts "You're all set!"
                sleep (1)
            end 
            if  self.find_byp_username(username) != p
                puts "Your username & password does not match..."
                sleep (0.04)
                puts "Please try again"
                sleep (1.2)
                system "clear"
                self.log_in
            end
        end
        @userid = self.find_idby_username(username)
        #Order.create(user_id: self.id) 
        # self.create_order(username)
        # Order.create(user_id: self.id)
    end

    def self.handle_new_user 
        # able to create empty username and password 
        system "clear" 
        username = self.tty_prompt.ask("Create a username", required: true) 
        # username = username.downcase
        if User.all.map(&:username).include?(username)
            puts 'This username already exist'
            sleep 5 / 2
            system "clear"
            sleep 1
            # self.handle_new_user 
            self.log_in
        else
            password = self.tty_prompt.mask("Create a password", required: true) 
        end   
        @userid = User.create(username: username, password: password) 
    end 
    
    def self.order_new_bk
        # Order.create(user_id: @new_user.id , starbucks_id: 1)
        Order.create(user_id: @userid.id , starbucks_id: 1)
    end

    def self.user_profile  
        system 'clear'
        puts "Your username: #{@userid.username}"
        puts "Your password: #{@userid.password}"
        sleep 2
    end 
    
    def self.delete_profile
        system 'clear'
        @userid.delete
        puts "Your account has been terminated"
        puts   "NO CAFFEINE"
        abort
    end 

    def self.select_starbucks 
        system 'clear'
        User.find_idby_username(@userid)
        star_choice = Starbucks.starbucks_name
        choices = self.tty_prompt.select("Which location would you like to order from?", star_choice) 
        if choices
            d = Starbucks.find_starby_user(choices)
            Order.create(user_id: @userid.id, starbucks_id: d.id)
        end
    end



end 

