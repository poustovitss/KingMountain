# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create!(name: 'Hard', email: 'admin@m.r', admin: true, balance: 0, level: 0, reffered_by: 0,  password: '123456')
user = User.create!(name: 'Test1', email: 'Test1@m.r', balance: 0, level: 0, reffered_by: 0,  password: '123456')
user = User.create!(name: 'Test2', email: 'Test2@m.r', balance: 0, level: 0, reffered_by: 0,  password: '123456')
user = User.create!(name: 'Test3', email: 'Test3@m.r', balance: 0, level: 0, reffered_by: 0,  password: '123456')
user = User.create!(name: 'Test4', email: 'Test4@m.r', balance: 0, level: 0, reffered_by: 0,  password: '123456')
user = User.create!(name: 'Test5', email: 'Test5@m.r', balance: 0, level: 0, reffered_by: 0,  password: '123456')
user = User.create!(name: 'Test6', email: 'Test6@m.r', balance: 0, level: 0, reffered_by: 0,  password: '123456')
user = User.create!(name: 'Test7', email: 'Test7@m.r', balance: 0, level: 0, reffered_by: 0,  password: '123456')
user = User.create!(name: 'Test8', email: 'Test8@m.r', balance: 0, level: 0, reffered_by: 0,  password: '123456')
user = User.create!(name: 'Test9', email: 'Test9@m.r', balance: 0, level: 0, reffered_by: 0,  password: '123456')
user = User.create!(name: 'Test10', email: 'Test10@m.r', balance: 0,  reffered_by: 0, level: 0, password: '123456')
user = User.create!(name: 'Test11', email: 'Test11@m.r', balance: 0, level: 0, reffered_by: 0,  password: '123456')
user = User.create!(name: 'Test12', email: 'Test12@m.r', balance: 0, level: 0, reffered_by: 0,  password: '123456')
user = User.create!(name: 'Test13', email: 'Test13@m.r', balance: 0, level: 0, reffered_by: 0,  password: '123456')
user = User.create!(name: 'Test14', email: 'Test14@m.r', balance: 0, level: 0, reffered_by: 0,  password: '123456')
user = User.create!(name: 'Test15', email: 'Test15@m.r', balance: 0, level: 0, reffered_by: 0,  password: '123456')
user = User.create!(name: 'Test16', email: 'Test16@m.r', balance: 0, level: 0, reffered_by: 0,  password: '123456')
user = User.create!(name: 'Test17', email: 'Test17@m.r', balance: 0, level: 0, reffered_by: 0,  password: '123456')
user = User.create!(name: 'Test18', email: 'Test18@m.r', balance: 0, level: 0, reffered_by: 0,  password: '123456')
user = User.create!(name: 'Test19', email: 'Test19@m.r', balance: 0, level: 0, reffered_by: 0,  password: '123456')
user = User.create!(name: 'Test20', email: 'Test20@m.r', balance: 0,  reffered_by: 0, level: 0, password: '123456')
bank = Bank.create!(name: 'FirstGame', desc: 'GoodLuck', active: true)