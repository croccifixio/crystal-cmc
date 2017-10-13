require "json"

module CMC
  class Token
    JSON.mapping(
      name: String | Nil,
      symbol: String | Nil,
      price_usd: String | Nil,
      percent_change_1h: String | Nil,
      percent_change_24h: String | Nil,
      percent_change_7d: String | Nil,
      last_updated: String | Nil
    )
  end
end
