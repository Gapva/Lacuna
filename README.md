# What is Lacuna?
Lacuna is an open-source, highly customizable engine/algorithm for extensive Sound Space maps.

# Setup
You must have a version of **Godot Engine Stable** that is the same or greater than **v3.5.1**.
After cloning this repository, add it to your **Godot** projects list, and open it.

Once you are inside the project, try to run it. You will encounter a dictionary error.
This is intentional, as it creates the user folder (`%appdata%\Lacuna\%`) *after* the dictionary checks occur.

To run the project without any errors, you will need to have:
- a `maps` directory
- a `worlds` directory
- a `setup.json` file with the path to a map and a world
- at least one map (directory with the map name and two files, `main.lacuna.json` and `main.mp3/ogg/wav`)
- at least one world (`.tres` file of type `WorldEnvironment` from **Godot**)

All of the items listed above are provided [here](https://github.com/Gapva/Lacuna/tree/main/templates)

You need copy everything in the `templates` folder into the `%appdata%\Lacuna\` or `C:\Users\**(yourusername)**\AppData\Roaming\Lacuna\`
