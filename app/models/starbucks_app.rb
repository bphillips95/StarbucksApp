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
        puts "Welcome to ABC coffee!😜 ☕️ 😜 ☕️ 😎 ☕️"
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
    username = @prompt.ask('Enter your username: ', required: true)
    #check if the entered username exists
    if User.all.map(&:username).exclude?(username)
        puts 'This username does not exist'
        sleep 3 / 2
        system "clear"
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
    username = @prompt.ask("Create a username", required: true) 
    #check if new username already exists
    if User.all.map(&:username).include?(username)
        puts 'This username already exist'
        sleep 5 / 2
        system "clear"
        sleep 1
        #redirect to log in option method
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
        choice = @prompt.select("What would you like to do") do |menu|
            #User Profile
            menu.choice "My Profile", -> {user_profile}
            #Delete Account
            menu.choice "Delete Account", -> {delete_profile}
            #Select Starbucks & Select Menu
            menu.choice "Ready for caffeine?", -> {select_starbucks}
            menu.choice "Break your computer????", -> {}
            #Exits App
            menu.choice "Exit", -> {abort}
        end 
    end 

#################### M A I N     M E N U       O P T I O NS #####################################
#-------------------------------- U S E R   P R O F I L E ------------------->

    def user_profile  
        system 'clear'
        puts "Your username: #{@userid.username}"
        puts "Your password: #{@userid.password}"
        choice = @prompt.select("What would you like to do?") do |menu|
            menu.choice "Delete Account", -> {delete_profile}
            menu.choice "Back", -> {main_menu}
        end
        sleep 1
    end 

    #--------------------------- D E L E T E    P R O F I L E ------------------->
    def delete_profile
        system 'clear'
        @userid.delete
        puts "Your account has been terminated"
        puts "NO CAFFEINE"
        abort
    end 


#-------------------------------- S E L E C T    S T A R B U C K S ------------------->

    def select_starbucks 
        system 'clear'
        find_uiby_username(@userid)
        star_choice = Starbucks.starbucks_name
        choices = @prompt.select("Which location would you like to order from?", star_choice) 
        if choices
            d = Starbucks.find_starby_user(choices)
            Order.create(user_id: @userid.id, starbucks_id: d.id)
        end
        select_item
    end
#-------------------------------------------------------------------------------------------------------------
#step 4
    #add items to cart and readd items to cart 
    def select_item
        system 'clear'
        drinks = %w(coffee☕️ tea🍵 latte☕️ water💧 cappucino☕️)
        selected_drinks = prompt.multi_select("Select drinks?", drinks)
        @@cart << selected_drinks
        view_cart
    end

#step 5
    def view_cart 
        system 'clear'
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
        choice = self.prompt.select("Are you done") do |menu|
            menu.choice "Yes", -> {checkout}
            menu.choice "No", -> {view_cart}
        end
    end 

#-------------------------------- C H E C K O U T ------------------->
    def checkout 
        system 'clear'
        if @@cart.count == 0 
            puts "Your cart is empty, please select an item"
            sleep 1
            main_menu 
        else
            puts "Your order has been confirmed of #{@@cart.join(", ")}. It will be ready for pickup in #{rand(20...40)} minutes" 
        end
    end 

#-------------------------------- C A N C E L   O R D E R ------------------->
    def cancel_order
        system 'clear'
        @@cart.clear
        puts "Your cart has been emptied"
        sleep(2)
        main_menu
        sleep(2)
    end 




################## H E L P E R   M E T H O D #########################
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