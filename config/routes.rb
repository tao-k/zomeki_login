mod = "login"

ZomekiLogin::Engine.routes.draw do
  root "#{mod}/contents#index"
end
