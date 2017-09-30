require "json"

module CMC
  class Token
    JSON.mapping(
      name: String,
      symbol: String,
      price_usd: String,
      percent_change_1h: String,
      percent_change_24h: String,
      percent_change_7d: String,
      last_updated: String
    )
  end
end
