# cmc

A simple CLI app that returns some data on various cryptocurrencies using the [CoinMarketCap API](https://coinmarketcap.com/api/).

## Setup

### Install Dependencies
```bash
shards
```

# Create an Executable File
```bash
crystal build src/cmc.cr
```

### Configure Environment Variables
Copy the `.env.example` file

```bash
cp .env.example .env
```

In the `.env` file:
- Set `X-CMC_PRO_API_KEY` to your CoinMarketCap API key.
- Set `TOKENS` to the cryptocurrency symbol (as a comma-separated list) whose data should be fetched and displayed. The default value is `BTC,ETH`.

## Usage

### Run with basic info
```bash
./cmc
```

### Run with additional info
```bash
./cmc -f        # same as `./cmc --full`
```

## License

[Unlicense](http://unlicense.org/)

## Contributors

- [Croccifixio](https://github.com/[Croccifixio]) - creator, maintainer
