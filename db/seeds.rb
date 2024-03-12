admin_user = AdminUser.new
admin_user.attributes = {
  email: 'info@asnica.co.jp',
  name: 'アスニカ管理者',
  password: 'asnica',
  password_confirmation: 'asnica',
  available: true,

}
admin_user.save!

system_config = SystemConfig.new

system_config.attributes = {
  site_url: 'https://asnica.co.jp',
}
system_config.save!
