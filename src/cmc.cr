require "./cmc/*"
require "dotenv"
require "http/client"
require "option_parser"

Dotenv.load ".env"

module CMC
  def call
    fullInfo = false

    OptionParser.parse do |parser|
      parser.on("-f", "--full", "Print full table") {
        fullInfo = true
      }
    end

    tokens = Array(Array(String)).new
    headings = fullInfo ? ["Name", "Symbol", "Price", "Last 1h", "Last 24h", "Last 7d", "Last updated"] : ["Symbol", "Price", "Last 1h", "Last 24h", "Last 7d"]

    headers = HTTP::Headers{"X-CMC_PRO_API_KEY" => ENV["CMC_PRO_API_KEY"]}
    response = HTTP::Client.get("https://pro-api.coinmarketcap.com/v2/cryptocurrency/quotes/latest?symbol=#{ENV["TOKENS"]}", headers)

    puts response.body
    TokensResponse.from_json(response.body).data.each do |_, tokenArray|
      token = tokenArray.first
      if fullInfo
        tokens.push([
          token.name,
          token.symbol,
          token.quote["USD"].price.to_s,
          token.quote["USD"].percent_change_1h.to_s,
          token.quote["USD"].percent_change_24h.to_s,
          token.quote["USD"].percent_change_7d.to_s,
          minutes_since(token.quote["USD"].last_updated),
        ])
      else
        tokens.push([
          token.symbol,
          token.quote["USD"].price.to_s,
          token.quote["USD"].percent_change_1h.to_s,
          token.quote["USD"].percent_change_24h.to_s,
          token.quote["USD"].percent_change_7d.to_s,
        ])
      end
    end

    print_table(headings, tokens)
  end

  def minutes_since(last_updated : String)
    last_updated_date = Time.parse_utc(last_updated, "%FT%H:%M:%S.%LZ")
    mins = ((Time.utc.to_unix - last_updated_date.to_unix) / 60).to_i.to_s
    "#{mins} minute #{if mins == "1"
                        ""
                      else
                        "s"
                      end} ago"
  end
end

class API
  extend CMC
end

API.call

######################################
# EXAMPLE JSON RESPONSE FROM THE API #
######################################
# {
#   "status": {
#     "timestamp": "2022-08-28T19:58:56.270Z",
#     "error_code": 0,
#     "error_message": null,
#     "elapsed": 42,
#     "credit_count": 1,
#     "notice": null
#   },
#   "data": {
#     "1": {
#       "id": 1,
#       "name": "Bitcoin",
#       "symbol": "BTC",
#       "slug": "bitcoin",
#       "num_market_pairs": 9708,
#       "date_added": "2013-04-28T00:00:00.000Z",
#       "tags": [
#         {
#           "slug": "mineable",
#           "name": "Mineable",
#           "category": "OTHERS"
#         }
#       ],
#       "max_supply": 21000000,
#       "circulating_supply": 19134868,
#       "total_supply": 19134868,
#       "is_active": 1,
#       "platform": null,
#       "cmc_rank": 1,
#       "is_fiat": 0,
#       "self_reported_circulating_supply": null,
#       "self_reported_market_cap": null,
#       "tvl_ratio": null,
#       "last_updated": "2022-08-28T19:57:00.000Z",
#       "quote": {
#         "USD": {
#           "price": 19988.711318080525,
#           "volume_24h": 23996668839.710613,
#           "volume_change_24h": -24.0566,
#           "percent_change_1h": -0.16802191,
#           "percent_change_24h": -0.11582498,
#           "percent_change_7d": -7.10125938,
#           "percent_change_30d": -16.29103052,
#           "percent_change_60d": -0.9335211,
#           "percent_change_90d": -34.75355242,
#           "market_cap": 382481352561.57684,
#           "market_cap_dominance": 39.5656,
#           "fully_diluted_market_cap": 419762937679.69,
#           "tvl": null,
#           "last_updated": "2022-08-28T19:57:00.000Z"
#         }
#       }
#     }
#   }
# }
