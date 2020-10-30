#!/bin/python3
import request
from bs4 import BeautifulSoup

def get_soup(url: str) -> BeautifulSoup:
	response = requests.get(url)
	return BeautifulSoup(response.content, 'html.parser')

def marinos():
	soup = get_soup("https://www.bing.com/images/search?q=animales+marinos&form=HDRSC3&first=1&scenario=ImageBasicHover")
	images = soup.find_all('img')
	t = [{'src': image.get('src'), 'alt': image.get('alt')} for image in images]
	print(f"{t}")

def tablas():
	soup = get_soup("https://en.wikipedia.org/wiki/List_of_Mexican_states_by_population")
	tr = soup.table.find_all('tr')
	for row in tr:
		cols = row.find_all('td')
		t = [ele.text.strip() for ele in cols]
		print(f"{t}")

print("A continuacion se mostraran imagenes de animales marinos")
marinos()

print("Se mostraran las tablas de la poblacion")
tablas()
