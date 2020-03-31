class Starbucks < ActiveRecord::Base
    has_many :orders 
    has_many :users, through: :orders
    
     #find starbucks instance by store name
     def self.find_starby_user(name)
        Starbucks.all.find do |starb|
            if starb.name == name 
                starb
            end
        end
    end
    #array of starbucks location names
    def self.starbucks_name
        star_names = Starbucks.all.map do |starbuck|
            starbuck.name
        end 
    end
end