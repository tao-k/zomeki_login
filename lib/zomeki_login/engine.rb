module ZomekiLogin
  class Engine < ::Rails::Engine
    config.autoload_paths << File.expand_path("../../../lib", __FILE__)
    config.after_initialize do |app|
      app.config.x.plugins << self
    end
  end
end
