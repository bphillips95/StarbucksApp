# class StarbucksApp
#     attr_reader :prompt
#     attr_accessor :orders, :starbucks, :users
#     @@cart = []
    
#     def initialize()
#         @prompt = TTY::Prompt.new 
#     end

#     def run 
#         welcome
#         # log_in
#         # main_menu
#         # User.select_starbucks
#         #  select_item
#     end 

#     def welcome
#         #Enter animation
#         puts "Welcome to Starbucks!😜 ☕️ 😜 ☕️ 😎 ☕️"
#         sleep(1)
#         log_in 
#     end 

#     def log_in
#         choice = self.prompt.select("What would you like to do") do |menu|
#             menu.choice "Log in", -> {handle_existing_user}
#             menu.choice "Sign up", -> {handle_new_user}
#         end 
#         main_menu
#     end 
  
#     def main_menu 
#         # view user profile 
#         # go to select_starbucks 
#         system 'clear'
#         choice = self.prompt.select("What would you like to do") do |menu|
#             menu.choice "View user profile", -> {User.user_profile}
#             menu.choice "Delete your account", -> {User.delete_profile}
#             menu.choice "Ready for caffeine?", -> {User.select_starbucks}
#             menu.choice "Break your computer????", -> {}
#             menu.choice "exit", -> {abort}
#         end 
#     end 

#     def select_starbucks
#         User.select_starbucks 
#         select_item
#     end 

#     def select_item
#         system 'clear'
#         drinks = %w(coffee☕️ tea🍵 latte☕️ water💧 cappucino☕️)
#         selected_drinks = prompt.multi_select("Select drinks?", drinks)
#         @@cart << selected_drinks
#         self.view_cart
#     end

#     def view_cart 
#         system 'clear'
#         puts "You selected #{@@cart.join(", ")}"
#         choice = self.prompt.select("Would you like to?") do |menu|   
#             menu.choice "Add to cart", -> {select_item}
#             menu.choice "Remove item from cart", -> {remove_items}
#             menu.choice "Proceed to checkout", -> {confirm_checkout}
#             menu.choice "Cancel Order", -> {cancel_order}
#         end 
#     end

#     def remove_items
#         system 'clear'
#         @@cart = @@cart.flatten
#         cart_arr = @@cart 
#         if cart_arr.count == 0 
#             puts "Your cart is empty, please add items"
#             view_cart
#         end
#         if cart_arr.count > 0 
#             splitted_cart = cart_arr.split(" ")
#             selected_items = prompt.multi_select("Which item would you like to remove?", splitted_cart)
#             selected_items.each do |del| 
#                 cart_arr.delete_at(cart_arr.index(del))
#             end 
#             # @@cart = cart_arr
#             sleep(0.6)
#             view_cart
#         end
#     end 

#     def confirm_checkout
#         system 'clear'
#         choice = self.prompt.select("Are you done") do |menu|
#             menu.choice "Yes", -> {checkout}
#             menu.choice "No", -> {view_cart}
#         end
#     end  

#     def checkout 
#         system 'clear'
#         puts "Your order has been confirmed of #{@@cart.join(", ")}.
#             It will be ready for pickup in #{rand(20...40)} minutes" 
#     end
#     def cancel_order
#         system 'clear'
#         @@cart.clear
#         puts "Your cart has been emptied"
#         sleep(2)
#         main_menu
#         sleep(2)
#     end 
# end 

# # def select_starbucks 
# #     # only if signing up
# #     system 'clear'
# #     choice = self.prompt.select("Please select a local Starbucks location ☕️☕️☕️") do |menu|
# #         menu.choice "Starbucks of Brooklyn", -> {Order.create(user_id: User.all.last.id, starbucks_id: Starbucks.all.first.id)}
# #         menu.choice "Starbucks of Manhattan", -> {Order.create(user_id: User.all.last.id, starbucks_id: Starbucks.all.second.id)}
# #     end 
# # end

# # put select_starbucks back into run file to avoid issue of having to run select starbucks(instance method)
# # from User class file 




# def handle_existing_user 
#     system "clear"
#     username = @prompt.ask('Enter your username: ', required: true)
#     if User.all.map(&:username).exclude?(username)
#         puts 'This username does not exist'
#         sleep 3 / 2
#         system "clear"
#         self.log_in
#     else 
#         p = @prompt.mask('Enter your password:', required: true)
#         if  self.find_byp_username(username) == p
#             puts "You're all set!"
#             sleep (1)
        
#         elsif  self.find_byp_username(username) != p
#             puts "Your username & password does not match..."
#             sleep (0.04)
#             puts "Please try again"
#             sleep (1.2)
#             system "clear"
#             self.log_in
#         end
#     end
#     @userid = find_uiby_username(username)
#     #Order.create(user_id: self.id) 
#     # self.create_order(username)
#     # Order.create(user_id: self.id)
# end

# def handle_new_user 
#     # able to create empty username and password 
#     system "clear" 
#     username = self.tty_prompt.ask("Create a username", required: true) 
#     # username = username.downcase
#     if User.all.map(&:username).include?(username)
#         puts 'This username already exist'
#         sleep 5 / 2
#         system "clear"
#         sleep 1
#         # self.handle_new_user 
#         self.log_in
#     else
#         password = self.tty_prompt.mask("Create a password", required: true) 
#     end   
#     @userid = User.create(username: username, password: password) 
# end 

# def order_new_bk
#     # Order.create(user_id: @new_user.id , starbucks_id: 1)
#     Order.create(user_id: @userid.id , starbucks_id: 1)
# end

# def user_profile  
#     system 'clear'
#     puts "Your username: #{@userid.username}"
#     puts "Your password: #{@userid.password}"
#     sleep 2
    
# end 

# def delete_profile
#     system 'clear'
#     @userid.delete
#     puts "Your account has been terminated"
#     puts   "NO CAFFEINE"
#     abort
# end 

# def select_starbucks 
#     system 'clear'
#     User.find_idby_username(@userid)
#     star_choice = Starbucks.starbucks_name
#     choices = self.tty_prompt.select("Which location would you like to order from?", star_choice) 
#     if choices
#         d = Starbucks.find_starby_user(choices)
#         Order.create(user_id: @userid.id, starbucks_id: d.id)
#     end
# end

# ################## H E L P E R   M E T H O D #########################
# # find password for a user using it's username
# def find_byp_username(uname)
#     User.all.find do |user|
#         if user.username == uname 
#             @a = "#{user.password}"
#         end
#     end
#     @a
# end 

# #find user instance using it's username
# def find_uiby_username(uname)
#     User.all.find do |user|
#         if user.username == uname 
#             user 
#         end
#     end
# end