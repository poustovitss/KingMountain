# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# developer = User.create!(name: 'Hard', email: 'v1rikman11@gmail.com', admin: true, balance: 0, level: 0, reffered_by: 0,  password: 'ulan2011')
# taras = User.create!(name: 'HuliichukAdmin', email: 'tarashuliichuk@gmail.com', admin: true, balance: 0, level: 1, reffered_by: 0,  password: 'eb848bf8c99d0b93d5a219b49ffe7d268577a6388a76bd7f7b9293600ec62c31')
user = User.create!(name: 'Алексей', email: 'Test1@m.r', balance: 0, proviant: true, level: 1, reffered_by: 0,  password: 'eqwqewqweqweeqwqweadsdasdzxcxzcgbahaq12312')
user = User.create!(name: 'Илола', email: 'Test2@m.r', balance: 0, proviant: true, level: 1, reffered_by: 0,  password: 'eqwqewqweqweeqwqweadsdasdzxcxzcgbahaq12312')
user = User.create!(name: 'Ваня', email: 'Test3@m.r', balance: 0, proviant: true, level: 1, reffered_by: 0,  password: 'eqwqewqweqweeqwqweadsdasdzxcxzcgbahaq12312')
user = User.create!(name: 'Best', email: 'Test4@m.r', balance: 0, proviant: true, level: 1, reffered_by: 0,  password: 'eqwqewqweqweeqwqweadsdasdzxcxzcgbahaq12312')
user = User.create!(name: 'Otlichnik', email: 'Test5@m.r', balance: 0, proviant: true, level: 1, reffered_by: 0,  password: 'eqwqewqweqweeqwqweadsdasdzxcxzcgbahaq12312')
user = User.create!(name: 'Попов', email: 'Test6@m.r', balance: 0, proviant: true, level: 1, reffered_by: 0,  password: 'eqwqewqweqweeqwqweadsdasdzxcxzcgbahaq12312')
user = User.create!(name: 'eclipse', email: 'Test7@m.r', balance: 0, proviant: true, level: 1, reffered_by: 0,  password: 'eqwqewqweqweeqwqweadsdasdzxcxzcgbahaq12312')
user = User.create!(name: 'katana', email: 'Test8@m.r', balance: 0, proviant: true, level: 1, reffered_by: 0,  password: 'eqwqewqweqweeqwqweadsdasdzxcxzcgbahaq12312')
user = User.create!(name: 'Werkol', email: 'Test9@m.r', balance: 0, proviant: true, level: 1, reffered_by: 0,  password: 'eqwqewqweqweeqwqweadsdasdzxcxzcgbahaq12312')
user = User.create!(name: 'Ekaterina', email: 'Test10@m.r', balance: 0,  reffered_by: 1, proviant: true, level: 0, password: 'eqwqewqweqweeqwqweadsdasdzxcxzcgbahaq12312')
user = User.create!(name: 'Шустров', email: 'Test11@m.r', balance: 0, proviant: true, level: 1, reffered_by: 0,  password: 'eqwqewqweqweeqwqweadsdasdzxcxzcgbahaq12312')
user = User.create!(name: 'Arkadio', email: 'Test12@m.r', balance: 0, proviant: true, level: 1, reffered_by: 0,  password: 'eqwqewqweqweeqwqweadsdasdzxcxzcgbahaq12312')
user = User.create!(name: 'Cheo', email: 'Test13@m.r', balance: 0, proviant: true, level: 1, reffered_by: 0,  password: 'eqwqewqweqweeqwqweadsdasdzxcxzcgbahaq12312')
user = User.create!(name: 'Chet', email: 'Test14@m.r', balance: 0, proviant: true, level: 1, reffered_by: 0,  password: 'eqwqewqweqweeqwqweadsdasdzxcxzcgbahaq12312')
user = User.create!(name: 'Blin', email: 'Test15@m.r', balance: 0, proviant: true, level: 1, reffered_by: 0,  password: 'eqwqewqweqweeqwqweadsdasdzxcxzcgbahaq12312')
user = User.create!(name: 'Паштет', email: 'Test16@m.r', balance: 0, proviant: true, level: 1, reffered_by: 0,  password: 'eqwqewqweqweeqwqweadsdasdzxcxzcgbahaq12312')
user = User.create!(name: 'Краказюль', email: 'Test17@m.r', balance: 0, proviant: true, level: 1, reffered_by: 0,  password: 'eqwqewqweqweeqwqweadsdasdzxcxzcgbahaq12312')
user = User.create!(name: 'Subaru', email: 'Test18@m.r', balance: 0, proviant: true, level: 1, reffered_by: 0,  password: 'eqwqewqweqweeqwqweadsdasdzxcxzcgbahaq12312')
user = User.create!(name: 'Amsterdam', email: 'Test19@m.r', balance: 0, proviant: true, level: 1, reffered_by: 0,  password: 'eqwqewqweqweeqwqweadsdasdzxcxzcgbahaq12312')
user = User.create!(name: 'Иван', email: 'Test20@m.r', balance: 0,  reffered_by: 1, proviant: true, level: 0, password: 'eqwqewqweqweeqwqweadsdasdzxcxzcgbahaq12312')
bank = Bank.create!(name: 'FirstGame', desc: 'GoodLuck', active: true)
systemfinance = Systemfinance.create!(name: 'Ваш зароботок', summa: 0)