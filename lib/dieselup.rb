require 'dieselup/version'
require 'active_support/core_ext/object/to_query'

module Dieselup
  class Base
    def self.up!
      open(Dieselup::Url::BASE) do |f|
        puts f.read
      end
    end
  end

  class Url
    BASE = 'https://diesel.elcat.kg/index.php'

    def self.get(query = {})
      "#{BASE}?#{query.to_param}"
    end
  end
end
