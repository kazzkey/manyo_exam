User.create!(
  name: '管理人',
  email: 'admin@example.com',
  password: '000000',
  password_confirmation: '000000',
  admin: true,
)
Label.create!([
  { name: '仕事' },
  { name: '勉強' },
  { name: '家事' },
  { name: '趣味' },
  { name: 'その他' },
])
