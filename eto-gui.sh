# Set up a small Eto.Forms + Gtk project from the command line.

# This assumes you have mono, fsharp and forge installed and in your path.

# Project name
PROJECT=foo

# Create the project
mkdir $PROJECT
cd $PROJECT
forge new project --name $PROJECT --folder src --template console

# Add Eto and Gtk dependencies
fsproj=src/$PROJECT/$PROJECT.fsproj
mono .paket/paket.exe add nuget Eto.Forms project $fsproj 
mono .paket/paket.exe add nuget Eto.Platform.Gtk3 project $fsproj 
mono .paket/paket.exe add nuget GtkSharp project $fsproj

# Small program to draw a circle on the screen
cat > src/$PROJECT/$PROJECT.fs <<HERE
module circle

open Eto.Forms
open Eto.Drawing

[<EntryPoint>]
let main argv =
  let app = new Application()
  let d = new Drawable()

  d.Paint.Add(fun e ->
    let g = e.Graphics
    g.TranslateTransform(100.f, 100.f)
    g.DrawEllipse(Colors.Blue, 0.f, 0.f, 300.f, 300.f)
  )

  let f = new Form(Topmost=true, ClientSize = new Size(600, 480))
  f.Content <- d
  f.Show()
  app.Run()
  0
HERE

# Forge has already generated a build script to invoke FAKE
sh build.sh 

# The executable and all its dependencies have been copied into build/
mono build/$PROJECT.exe
