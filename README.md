# cmc

A simple CLI app that returns some data on various cryptocurrencies using the [CoinMarketCap API](https://coinmarketcap.com/api/).

## Installation

Clone or download the repository, then run `crystal build src/cmc.cr` to build the package.

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

The list of cryptocurrencies to display is maintained in the `src/cmc/token_list.cr` file. It requires the use of IDs as determined by the CoinMarketCap API. The default list is shown below:

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

- [[Croccifixio]](https://github.com/[your-github-name]) Croccifixio - creator, maintainer
