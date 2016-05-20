# Set up a small Gtk# project from the command line.

# This assumes you have mono, fsharp and forge installed and in your path.

# Project name
PROJECT=foo

# Create the project
mkdir $PROJECT
cd $PROJECT
forge new project --name $PROJECT --folder src --template console

# Add Gtk dependencies
fsproj=src/$PROJECT/$PROJECT.fsproj
mono .paket/paket.exe add nuget GtkSharp project $fsproj

# Sample gtk program
cat > src/$PROJECT/$PROJECT.fs <<HERE
module gtkexample

open System
open Gtk

let QuitApp() =
  Console.WriteLine("Bye!")
  Application.Quit()

[<EntryPoint>]
let main argv =
  Application.Init();
  let window = new Window("Gtk# Example")

  let box = new Gtk.VBox()
  let clicky_btn = new Button("Click Me")
  let quit_btn = new Button("Quit")

  clicky_btn.Clicked.AddHandler (fun s a -> Console.WriteLine("Click!"))
  quit_btn.Clicked.AddHandler (fun s a -> QuitApp())

  box.PackStart(clicky_btn, false, false, (uint32 0))
  box.PackStart(quit_btn, false, false, (uint32 0))
  window.Add(box)

  window.DeleteEvent.AddHandler (fun s a -> QuitApp()) 
  window.ShowAll()

  Application.Run()
  0
HERE

# Forge has already generated a build script to invoke FAKE
sh build.sh 

# The executable and all its dependencies have been copied into build/
mono build/$PROJECT.exe
