# The basic "hello world" project.

# This assumes you have mono, fsharp and forge installed and in your path.

# Project name
PROJECT=helloworld

# Create the project
mkdir $PROJECT
cd $PROJECT
forge new project --name $PROJECT --folder src --template console

cat > src/$PROJECT/$PROJECT.fs <<HERE
[<EntryPoint>]
let main argv =
  printfn("Hello world")
  0
HERE

# Forge has already generated a build script to invoke FAKE
sh build.sh 

# The executable and all its dependencies have been copied into build/
mono build/$PROJECT.exe
