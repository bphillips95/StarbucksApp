class StarbucksApp
    attr_reader :prompt
    attr_accessor :orders, :starbucks, :users

    @@cart = []
    
    def initialize()
        @prompt = TTY::Prompt.new 
    end

    def run 
        welcome
    end 

    #step 1 
    def welcome
        #Enter animation
        3.times do 
            play_music
        end
        CoffeeMan.go
        puts "WELCOME TO STARBUCKS W/ ANNIE & BARUCH! 😜 ☕️ 😜 ☕️ 😎 ☕️".colorize(:blue)
        system('say "Welcome to Starbucks with Annie and Baruch!"')
        puts "Caution: To order from this application, you have to hangout with Baruch and Annie.".colorize(:red)
        system('say "Caution: To order from this application, you have to hangout with Baruch and Annie."')
        sleep(1)
        log_in 
    end 

    #step 2
    def log_in
        choice = @prompt.select("What would you like to do") do |menu|
            menu.choice "Log in", -> {handle_existing_user}
            menu.choice "Sign up", -> {handle_new_user}
        end 
    end 

#-------------------------------- L O G  I N ----------------------------------------------->
#log in for existing user
def handle_existing_user 
    system "clear"
    CoffeeMan.stay_logo
    username = @prompt.ask('Enter your username: ', required: true)
    #check if the entered username exists
    if User.all.map(&:username).exclude?(username)
        puts 'This username does not exist'
        sleep 3 / 2
        system "clear"
        CoffeeMan.stay_logo
        self.log_in
    else 
        #enter a password and look to see if it matches 
        p = @prompt.mask('Enter your password:', required: true)
        if  self.find_byp_username(username) == p
            puts "You're all set!"
            sleep (1)
        #if the entered password doesn't match, redirects to log in options 
        elsif  self.find_byp_username(username) != p
            puts "Your username & password does not match..."
            sleep (0.04)
            puts "Please try again"
            sleep (1.2)
            system "clear"
            CoffeeMan.stay_logo
            self.log_in
        end
    end
    #find the user instance with the username from above and assigns it to the @userid variable
    @userid = find_uiby_username(username)
    #directs you to the next step, main menu
    main_menu
end

# -------------------------------- S I G N  U P ----------------------------------------------->
#sign up a new user
def handle_new_user 
    system "clear" 
    CoffeeMan.stay_logo
    username = @prompt.ask("Create a username", required: true) 
    #check if new username already exists
    if User.all.map(&:username).include?(username)
        puts 'This username already exist'
        sleep 5 / 2
        system "clear"
        sleep 1
        #redirect to log in option method
        CoffeeMan.stay_logo
        self.log_in
    else
        #if new username doesn't exist, create a new password
        password = @prompt.mask("Create a password", required: true) 
    end   
    #after everything, create a new user instance 
    @userid = User.create(username: username, password: password) 
    main_menu
end
#--------------------------------------------------------------------------------------------------------

    #step 3
    def main_menu 
        # view user profile 
        # go to select_starbucks 
        system 'clear'
        CoffeeMan.stay_logo
        puts "WOOHOO! Looking forward to hanging out! 😆".colorize(:magenta)
        choice = @prompt.select("What would you like to do") do |menu|
            system('say "WOOHOO! Looking forward to hanging out!"')
            #User Profile
            menu.choice "My Profile", -> {user_profile}
            #Delete Account
            # menu.choice "Delete Account", -> {delete_profile} (Alredy in My Profile option)
            #Select Starbucks & Select Menu
            menu.choice "GET CAFFEINE!", -> {select_starbucks}
            menu.choice "Break Computer?!?!", -> {break_comp}
            #Exits App
            menu.choice "Exit", -> {exit_star}
        end 
    end 

#################### M A I N     M E N U     O P T I O NS ####################################################
#-------------------------------- U S E R   P R O F I L E ------------------->

    def user_profile  
        system 'clear'
        CoffeeMan.stay_logo
        choice = @prompt.select("~P R O F I L E~") do |menu|
            puts "HELLO #{@userid.username}".colorize(:light_blue)
            menu.choice "Update Username", -> {change_username}
            menu.choice "Update Password", -> {change_password}
            menu.choice "Delete Account", -> {delete_profile}
            menu.choice "Back", -> {main_menu}
        end
        sleep 1
    end 

#--------------------------- D E L E T E    P R O F I L E ------------------->
    def delete_profile
        system 'clear'
        CoffeeMan.stay_logo
        @userid.delete
        puts "Your account has been terminated"
        puts "NO CAFFEINE"
        stop_music
        abort
    end 

#--------------------------- B R E A K    C O M P U T E R ------------------->
    def break_comp
        # play_error
        stop_music
        10000.times do 
            system('say "DO NOT DO THIS! WE CAN WORK IT OUT!"')
            puts "ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G... ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...ERROR! COMPUTER DOWN! C O M P U T E R  B R E A K I N G...".colorize(:color => :red, :background => :black)
        end
    end


#-------------------------------- S E L E C T    S T A R B U C K S ------------------->

    def select_starbucks 
        system 'clear'
        CoffeeMan.stay_logo
        find_uiby_username(@userid)
        star_choice = Starbucks.starbucks_name
        choices = @prompt.select("Which location would you like to order from?", star_choice) 
        if choices
            d = Starbucks.find_starby_user(choices)
            Order.create(user_id: @userid.id, starbucks_id: d.id)
        end
        select_item
    end


#-------------------------------- E X I T  A P P  --------------------------------------->

    def exit_star
        stop_music
        abort("You're logged out")
    end
#-------------------------------------------------------------------------------------------------------------
#step 4
    #add items to cart and readd items to cart 
    def select_item
        system 'clear'
        CoffeeMan.stay_logo
        drinks = %w(coffee☕️ tea🍵 latte☕️ water💧 cappucino☕️)
        selected_drinks = prompt.multi_select("Select drinks?", drinks)
        @@cart << selected_drinks
        view_cart
    end

#step 5
    def view_cart 
        system 'clear'
        CoffeeMan.stay_logo
        puts "You selected #{@@cart.join(", ")}"
        choice = self.prompt.select("Would you like to?") do |menu|   
            menu.choice "Add to cart", -> {select_item}
            menu.choice "Remove item from cart", -> {remove_items}
            menu.choice "Proceed to checkout", -> {confirm_checkout}
            menu.choice "Cancel Order", -> {cancel_order}
        end 
    end

#################### V I E W    C A R T    O P T I O NS #####################################
#-------------------------------- R E M O V E    I T E M S ------------------->
    def remove_items
        system 'clear'
        CoffeeMan.stay_logo
        @@cart = @@cart.flatten
        cart_arr = @@cart 
        if cart_arr.count == 0 
            puts "Your cart is empty, please add items"
            sleep 1
            view_cart
        end
        if cart_arr.count > 0 
            splitted_cart = cart_arr.split(" ")
            selected_items = prompt.multi_select("Which item would you like to remove?", splitted_cart)
            selected_items.each do |del| 
                cart_arr.delete_at(cart_arr.index(del))
            end 
            # @@cart = cart_arr
            sleep(0.6)
            view_cart
        end
    end 

#-------------------------------- C O N F I R M   C H E C K O U T ------------------->
    def confirm_checkout
        system 'clear'
        CoffeeMan.stay_logo
        choice = self.prompt.select("Are you done") do |menu|
            menu.choice "Yes", -> {checkout}
            menu.choice "No", -> {view_cart}
        end
    end 

#-------------------------------- C H E C K O U T ------------------->
    def checkout 
        system 'clear'
        CoffeeMan.stay_logo
        if @@cart.count == 0 
            puts "Your cart is empty, please select an item"
            sleep 1
            main_menu 
        else
            system('say "Already blocked it in my calendar!"')
            puts "Your order has been confirmed of #{@@cart.join(", ")}. It will be ready for pickup in #{rand(20...40)} minutes! Can't wait to hangout!"
            puts "Already blocked it in my calendar!".colorize(:color => :light_blue, :background => :yellow)
            stop_music 
            sleep 2
        end
    end 

#-------------------------------- C A N C E L   O R D E R ------------------->
    def cancel_order
        system 'clear'
        CoffeeMan.stay_logo
        @@cart.clear
        puts "Your cart has been emptied"
        sleep(0.09)
        main_menu
        sleep(2)
    end 




################## H E L P E R   M E T H O D #########################
#start music
def play_music
    pid = fork{ exec 'afplay', "app/models/coffee_music.mp3" }
end

#end music
def stop_music
    pid = fork{ exec 'afplay', "app/models/coffee_music.mp3" }
    system 'killall afplay'
end

#change user's username
    def change_username
        system "clear"
        CoffeeMan.stay_logo
        usename = @prompt.ask("Enter a new username", required: true) 
        if @userid.username == usename
            puts "You entered the same username"
            choice = @prompt.select("Choose one of the following options: ") do |menu|
                menu.choice "Change Username", -> {change_username}
                menu.choice "Nevermind", -> {user_profile}
            end
        end
        if @userid.username != usename
            @userid.username = usename
            puts "Your username has been updated!"
            sleep (1)
            user_profile
        end
    end

#change user's password
    def change_password
        system "clear"
        CoffeeMan.stay_logo
        password = @prompt.mask("Enter a new username", required: true) 
        if @userid.password == password
            puts "You entered the same password"
            choice = @prompt.select("Choose one of the following options: ") do |menu|
                menu.choice "Change Password", -> {change_password}
                menu.choice "Nevermind", -> {user_profile}
            end
        end
        if @userid.password != password
            @userid.password = password
            puts "Your password has been updated!"
            sleep (1)
            user_profile
        end
    end

# find password for a user using it's username
    def find_byp_username(uname)
        User.all.find do |user|
            if user.username == uname 
                @a = "#{user.password}"
            end
        end
        @a
    end 

#find user instance using it's username
    def find_uiby_username(uname)
        User.all.find do |user|
            if user.username == uname 
                user 
            end
        end
    end
end
#-----------------------E N D-------------------------------------------->
