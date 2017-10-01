# cmc

A simple CLI app that returns some data on various cryptocurrencies using the [CoinMarketCap API](https://coinmarketcap.com/api/).

## Installation

Clone or download the repository and execute the following commands:
```bash
cd crystal-cmc
crystal deps                    # install dependencies
crystal build src/cmc.cr        # create an executable file
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

[Free Public License](https://opensource.org/licenses/FPL-1.0.0)

## Contributors

- [Croccifixio](https://github.com/[Croccifixio]) - creator, maintainer
