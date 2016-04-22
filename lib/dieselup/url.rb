module Dieselup
  class Url
    BASE = 'https://diesel.elcat.kg/index.php'

    def self.get(query = {})
      "#{BASE}?#{query.to_param}"
    end
  end
end