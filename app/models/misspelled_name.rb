# def name_misspeller
#     vowels = ["a","e","i","o","u"]
#     puts "What is your name?"
#     name = gets.chomp
#     name_array = name.split("")
#     wrong_name_array = []
#     name_array.each do |character|
#         is_consonant = true
#         vowels.each do |vowel|
#         if character.downcase == vowel
#             wrong_name_array << vowels.sample
#             is_consonant = false
#         end
#         end
#         if is_consonant
#         wrong_name_array << character
#         end
#     end
#     wrong_name_array.join.capitalize
#     wrong_name = wrong_name_array.join.capitalize
#     puts "Nice to meet you, #{wrong_name}"
#     end
#     name_misspeller