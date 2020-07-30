#!/usr/bin/env python
# coding=utf-8
import sys
from os import environ

from lifxlan import LifxLAN

def main():
    lan = LifxLAN()
    lights = lan.get_tilechain_lights()

    if not lights:
      print("Lights not found.")
      raise("Lights not found.")

    print("Lights found:")
    for light in lights:
      print(light)

    tile_number = 0
    if environ.get('TILE_NUMBER') is not None:
      tile_number = os.environ['TILE_NUMBER']

    # Tile Chain
    tiles = lights[tile_number]

    # milisecond delay in changing the color
    color_delay = 1000

    # Available colors
    a = (22573, 65535, 33183, 3500)
    b = (24029, 65535, 21626, 3500)
    c = (24426, 61139, 22213, 3500)
    d = (22068, 35606, 40227, 3500)
    none = (24426, 12584, 22213, 3500)

    for i in range(1, 6):

        if sys.argv[i] == "0":
            tiles.set_tile_colors(i - 1, [none] * 64, color_delay)

        elif sys.argv[i] == "1":
            tiles.set_tile_colors(i - 1, [d] * 64, color_delay)

        elif sys.argv[i] == "2":
            tiles.set_tile_colors(i - 1, [c] * 64, color_delay)

        elif sys.argv[i] == "3":
            tiles.set_tile_colors(i - 1, [b] * 64, color_delay)

        elif sys.argv[i] == "4":
            tiles.set_tile_colors(i - 1, [a] * 64, color_delay)


if __name__ == "__main__":
    main()
