#!/usr/bin/python

import os
from pycoingecko import CoinGeckoAPI

cg = CoinGeckoAPI()

ids = ["bitcoin", "litecoin", "ethereum", "binancecoin"]

try:
    coins_prices = cg.get_price(ids, vs_currencies="usd")
    txt = "<img>{path}/../icons/crypto.svg</img><txt>  BTC: {btc}  ETH: {eth}</txt><tool></tool>".format(
        btc=round(coins_prices["bitcoin"]["usd"]),
        eth=round(coins_prices["ethereum"]["usd"]),
        path=os.path.dirname(os.path.realpath(__file__))
    )

    print(txt)
except Exception:
    print("No data")
