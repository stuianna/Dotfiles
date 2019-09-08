#!/usr/bin/env python3

import configparser
import sys
import requests
from decimal import Decimal

#Change this to the full path of your crypto-config file if necessary
configFile = '/home/stuart/.bin/crypto-config'

config = configparser.ConfigParser()

# File must be opened with utf-8 explicitly
with open(configFile, 'r', encoding='utf-8') as f:
	config.read_file(f)

# Everything except the general section
currencies = [x for x in config.sections() if x != 'general']
base_currency = config['general']['base_currency']
params = {'convert': base_currency}
mode = config['general']['mode']

if mode == 'cyclic':

    currentTicker = config['general']['ticker']
    newIndex = currencies.index(currentTicker) + 1
    config.set('general','ticker',currencies[newIndex % len(currencies)])
    currencies = [currentTicker]
    with open(configFile, 'w', encoding='utf-8') as f:
        config.write(f)

elif mode == 'all':
    pass
else:
    pass

for currency in currencies:
        icon = config[currency]['icon']

        # Return an empty string if request fails
        try:
            json = requests.get(f'https://api.coinmarketcap.com/v1/ticker/{currency}',
                                                                params=params).json()[0]
        except:
            sys.stdout.write('')
            sys.exit()

        local_price = round(Decimal(json[f'price_{base_currency.lower()}']), 2)
        change_24 = float(json['percent_change_24h'])

        display_opt = config['general']['display']
        if display_opt == 'both' or display_opt == None:
            sys.stdout.write(f'{icon}: {local_price} ({change_24:+}%)')
        elif display_opt == 'percentage':
            sys.stdout.write(f'{icon}: {change_24:+}%')
        elif display_opt == 'price':
            sys.stdout.write(f'{icon}: {local_price}')
