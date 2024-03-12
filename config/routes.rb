class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end
Rails.application.routes.draw do
  draw :admin
  draw :api
  # 開発環境で、localhost:xxxx/letter_opener　でメールを確認出来る
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
