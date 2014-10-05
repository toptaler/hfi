namespace :hfi do
  desc "TODO"
  task seed_users: :environment do
    User.create(id: 1, first_name: 'Alec', last_name: 'Gleichner')
    User.create(id: 2, first_name: 'Lorenz', last_name: 'Hyatt')
    User.create(id: 3, first_name: 'Dawson', last_name: 'Hackett')
    User.create(id: 4, first_name: 'Berneice', last_name: 'Trantow')
    User.create(id: 5, first_name: 'Bailee', last_name: 'Ferry')
    User.create(id: 6, first_name: 'Lesly', last_name: 'Littel')
    User.create(id: 7, first_name: 'Jaquan', last_name: 'Steuber')
    User.create(id: 8, first_name: 'Deon', last_name: 'Balistreri')
    User.create(id: 9, first_name: 'Makayla', last_name: 'Pouros')
    User.create(id: 10, first_name: 'Brock', last_name: 'Nader')
    User.create(id: 11, first_name: 'Emmy', last_name: 'Ortiz')
    User.create(id: 12, first_name: 'Aric', last_name: 'Steuber')
    User.create(id: 13, first_name: 'Brandon', last_name: 'Sawayn')
    User.create(id: 14, first_name: 'Sonny', last_name: 'Ernser')
    User.create(id: 15, first_name: 'Lee', last_name: 'Wolff')
    User.create(id: 16, first_name: 'Lexi', last_name: 'Shields')
    User.create(id: 17, first_name: 'Jerrold', last_name: 'Stanton')
    User.create(id: 18, first_name: 'Kelsi', last_name: 'Crooks')
    User.create(id: 19, first_name: 'Kumi', last_name: 'Cheung')
    User.create(id: 20, first_name: 'Rod', last_name: 'White')
  end

end
