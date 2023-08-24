# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Admin.create!(
#   email: "a@a",
#   password: "aaaaaa"
# )

Admin.create!(email: 'meshitomo@meshitomo.com', password: 'meshitomo')

User.create!(
  [
    {email: 'a@meshitomo.com', password: 'aaaaaa', 
    last_name: '山田', first_name: '太郎', last_name_kana: 'ヤマダ', first_name_kana: 'タロウ',
    nickname: 'タロちゃん', postal_code: '7400304', address: '山口県岩国市',
    telephone_number: '01012345678', gender: 0,
    image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")},
    {email: 'b@meshitomo.com', password: 'bbbbbb', 
    last_name: '鈴木', first_name: '梅', last_name_kana: 'スズキ', first_name_kana: 'ウメ',
    nickname: 'ウメ子', postal_code: '3150035', address: '茨城県石岡市',
    telephone_number: '02012345678', gender: 1,
    image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")},
    {email: 'c@meshitomo.com', password: 'cccccc', 
    last_name: '佐藤', first_name: '詩織', last_name_kana: 'サトウ', first_name_kana: 'シオリ',
    nickname: 'シオン', postal_code: '9900063', address: '山形県山形市',
    telephone_number: '03012345678', gender: 1,
    image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")},
    {email: 'd@meshitomo.com', password: 'dddddd', 
    last_name: '西園寺', first_name: '明', last_name_kana: 'サイオンジ', first_name_kana: 'アキラ',
    nickname: 'あき', postal_code: '1560044', address: '東京都世田谷区',
    telephone_number: '04012345678', gender: 2,
    image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user4.jpg"), filename:"sample-user4.jpg")}
  ]
)
