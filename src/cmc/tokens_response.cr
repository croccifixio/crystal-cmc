require "json"

module CMC
  class Quote
    include JSON::Serializable
    property price : Float64
    property percent_change_1h : Float64
    property percent_change_24h : Float64
    property percent_change_7d : Float64
    property last_updated : String
  end

  class Token
    include JSON::Serializable
    property name : String
    property symbol : String
    property quote : Hash(String, Quote)
  end

  class TokensResponse
    include JSON::Serializable
    property data : Hash(String, Array(Token))
  end
end
