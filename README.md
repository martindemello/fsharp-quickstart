# F# Quickstart

## What:
A collection of shell scripts that work through all the steps of setting up
various F# projects via [forge](http://fsprojects.github.io/Forge/).

## Why:
I could not find any detailed documentation on setting up and running F#
projects from the linux command line.

## Prerequisites:
The scripts assume that `mono`, `fsharp` and `forge` are all installed and in your path.

To install Forge and have it executable via `forge`:

````
   git clone https://github.com/fsharp-editing/Forge.git
   cd Forge/
   sh build.sh 
   echo "mono `pwd`/temp/bin/Forge.exe \"$@\"" > $BIN_DIR/forge
   chmod a+x $BIN_DIR/forge
````

(Note that in general you have to execute .NET executables via `mono File.exe`
rather than just `File.exe`)
