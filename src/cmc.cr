require "./cmc/*"
require "http/client"
require "option_parser"

module CMC
  def call
    fullInfo = false

    OptionParser.parse! do |parser|
      parser.on("-f", "--full", "Print full table")  {
        fullInfo = true
      }
    end

    tokens = Array(Array(String)).new
    headings = fullInfo ?
      [ "Name", "Symbol", "Price", "Last 1h", "Last 24h", "Last 7d", "Last updated" ] :
      [ "Symbol", "Price", "Last 1h", "Last 24h", "Last 7d" ]

    token_list.each do |token|
      response = HTTP::Client.get("https://api.coinmarketcap.com/v1/ticker/#{token}/")
      token = ( Array(Token).from_json(response.body).first )

      if fullInfo
        tokens.push([
          validate(token.name),
          validate(token.symbol),
          validate(token.price_usd),
          validate(token.percent_change_1h),
          validate(token.percent_change_24h),
          validate(token.percent_change_7d),          
          minutes_since( validate(token.last_updated) )
        ])
      else
        tokens.push([
          validate(token.symbol),
          validate(token.price_usd),
          validate(token.percent_change_1h),
          validate(token.percent_change_24h),
          validate(token.percent_change_7d)
        ])
      end
    end

    print_table(headings, tokens)
  end

  def minutes_since(last_updated : String)
    if last_updated == "N/A"
      last_updated
    else
      ( (Time.now.epoch - last_updated.to_i) / 60 ).to_s  + " minutes ago"
    end
  end

  def validate(value : String | Nil)
    value.nil? ? "N/A" : value.to_s
  end
end

class API
  extend CMC
end

API.call


######################################
# EXAMPLE JSON RESPONSE FROM THE API #
######################################
# [
#   {
#     id": "bitcoin",
#     "name": "Bitcoin",
#     "symbol": "BTC",
#     "rank": "1",
#     "price_usd": "4182.83",
#     "price_btc": "1.0",
#     "24h_volume_usd": "1388010000.0",
#     "market_cap_usd": "69413018143.0",
#     "available_supply": "16594750.0",
#     "total_supply": "16594750.0",
#     "percent_change_1h": "-0.01",
#     "percent_change_24h": "0.4",
#     "percent_change_7d": "15.91",
#     "last_updated": "1506720851"
#   }
# ]
