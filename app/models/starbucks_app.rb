class StarbucksApp
    attr_reader :prompt, :users
    attr_accessor :orders, :starbucks, :items
    @@cart = []
    
    def initialize()
        @prompt = TTY::Prompt.new 
    end

    def run 
        welcome
        log_in
        select_starbucks
        select_item
        # DO NOT RUN confirm_checkout
        # DO NOT RUN # view_cart
    end 

    def welcome
        #Enter animation
        puts "Welcome to Starbucks!😜 ☕️ 😜 ☕️ 😎 ☕️"
        sleep(1)
    end 

    def log_in
        choice = self.prompt.select("Would you like to do") do |menu|
            menu.choice "Log in", -> {User.handle_existing_user}
            menu.choice "Sign up", -> {User.handle_new_user}
            #user_man = User.all.last <---why do we need thi?
        end 
    end 

    def select_starbucks 
        # only if signing up
        system 'clear'
        choice = self.prompt.select("Please select a local Starbucks location ☕️☕️☕️") do |menu|
            menu.choice "Starbucks of Brooklyn", -> {Order.create(user_id: User.all.last.id, starbucks_id: Starbucks.all.first.id)}
            menu.choice "Starbucks of Manhattan", -> {Order.create(user_id: User.all.last.id, starbucks_id: Starbucks.all.second.id)}
        end 
    end

    def select_item
        drinks = %w(coffee☕️ tea🍵 latte☕️ water💧 cappucino☕️)
        selected_drinks = prompt.multi_select("Select drinks?", drinks)
        @@cart << selected_drinks
        self.view_cart
    end

    def view_cart 
        puts "You selected #{@@cart.join(", ")}"
        choice = self.prompt.select("Would you like to?") do |menu|   
            menu.choice "Add to cart", -> {self.select_item}
            menu.choice "Remove item from cart", -> {self.remove_items}
            menu.choice "Proceed to checkout", -> {confirm_checkout}
            menu.choice "Break your computer????"
        end 
    end

    def remove_items
        cart_arr = @@cart.flatten
        splitted_cart = cart_arr.split(" ")
        selected_items = prompt.multi_select("Which item would you like to remove?", splitted_cart)
        selected_items.each do |del| 
            cart_arr.delete_at(cart_arr.index(del))
        end 
        @@cart = cart_arr
        sleep(0.6)
        view_cart
    end
    def confirm_checkout
        choice = self.prompt.select("Are you done") do |menu|
            menu.choice "Yes", -> {checkout}
            menu.choice "No", -> {view_cart}
        end
    end  

    def checkout 
        puts "Your order has been confirmed of #{@@cart.join(", ")}.
        It will be ready for pickup in #{rand(30...80)} minutes" 
    end

end 


# if User.all.map(&:username).include?(username)
#     set same variable to last user in sign up  method and name instance in login method
#  User profile option in menu which allows you to view name username password (change password) and delete account option

# lowercase login automatiocally reverts to uppercase