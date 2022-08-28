# cmc

A simple CLI app that returns some data on various cryptocurrencies using the [CoinMarketCap API](https://coinmarketcap.com/api/).

## Setup

### Set CoinMarketCap API Key
Create an `.env` file in the root of the project and fill in your API key.
```
CMC_PRO_API_KEY=<your_api_key>
```

### Install Dependencies
```bash
shards
```

# Create an Executable File
```bash
crystal build src/cmc.cr
```

## Usage

### Run with basic info
```bash
./cmc
```

### Run with additional info
```bash
./cmc -f        # same as `./cmc --full`
```

## Configuring

The list of cryptocurrencies to display is maintained in the `src/cmc/token_list.cr` file. Each string maches the ID of a token on the CoinMarketCap API ([full list of IDs](https://api.coinmarketcap.com/v1/ticker/)). The default list of cryptocurrencies is shown below:

```crystal
module CMC
  def token_list
    [
      "bitcoin",
      "ethereum"
    ]
  end
end
```

## License

[Unlicense](http://unlicense.org/)

## Contributors

- [Croccifixio](https://github.com/[Croccifixio]) - creator, maintainer
