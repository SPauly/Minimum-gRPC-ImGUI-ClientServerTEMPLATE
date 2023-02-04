#!/bin/bash

# Check the current operating system
uname_os=$(uname -s)
#if [ "$uname_os" == "MINGW64_NT"* ] || [ "$uname_os" == "MINGW32_NT"* ]; then
#  OS="Windows"
#else
#  OS="Linux"
#fi

OS="Windows"

# Change the include path for an external grpc
if [ "$OS" == "Linux" ]; then
  # Get the value of SUP_GRPC_BINARIES_DIR from build/CMakeCache.txt
  VAR_SUP_GRPC_BINARIES_DIR=$(grep SUP_GRPC_BINARIES_DIR build/CMakeCache.txt | cut -d'=' -f2 | tr -d '[:space:]' | sed "s#SUP_GRPC_BINARIES_DIR:PATH=##g")

  # Add the value of VAR_SUP_GRPC_BINARIES_DIR to the include path in c_cpp_properties.json
  jq ".configurations[].includePath |= . + [\"$VAR_SUP_GRPC_BINARIES_DIR/**\"]" c_cpp_properties.json > c_cpp_properties_tmp.json && mv c_cpp_properties_tmp.json c_cpp_properties.json

  # Get the value of the SUP_PROJECT_NAME from custom-config.cmake
  VAR_NEW=$(grep SUP_PROJECT_NAME cmake/custom-config.cmake | cut -d'=' -f2 | tr -d '[:space:]')

  # Get the value of the SUP_PROJECT_NAME_old from custom-config.cmake
  VAR_OLD=$(grep SUP_PROJECT_NAME_old cmake/custom-config.cmake | cut -d'=' -f2 | tr -d '[:space:]')

  # Find all files in the repository and replace the string
  find . -type f -exec sed -i '' "s/$VAR_OLD/$VAR_NEW/g" {} +

  # Rename "$VAR_OLD"_protocol.proto to "$VAR_NEW"_protocol.proto
  mv utils/"$VAR_OLD"_protocol.proto utils/"$VAR_NEW"_protocol.proto

fi

if [ "$OS" = "Windows" ]; then
  # Get the value of SUP_GRPC_BINARIES_DIR from CMakeCache.cmake
  VAR_SUP_GRPC_BINARIES_DIR=$(powershell.exe -Command "Get-Content build/CMakeCache.txt | Select-String 'SUP_GRPC_BINARIES_DIR:PATH' | ForEach-Object { \$_.Line } | ForEach-Object { \$_ -replace 'SUP_GRPC_BINARIES_DIR:PATH=','' }")
  echo "\n [-----SETUP-----] Retrieved VAR_SUP_GRPC_BINARIES_DIR $VAR_SUP_GRPC_BINARIES_DIR"
  
  # Add the value of VAR_SUP_GRPC_BINARIES_DIR to the include path in c_cpp_properties.json
  echo "\n [-----SETUP-----] Add VAR_SUP_GRPC_BINARIES_DIR to c_cpp_properties.json"
  # Read the file content
  FILE_CONTENT=$(powershell.exe -Command "Get-Content .vscode/c_cpp_properties.json") 
  # convert to PowerShell object
  export FILE_CONTENT
  JSON_OBJ=$(powershell.exe -Command "ConvertFrom-Json \$env:FILE_CONTENT")
  # Modify the includePath of all configurations
  export JSON_OBJ
  powershell.exe -Command "foreach (\$config in \$env:JSON_OBJ.configurations)
  {
     \$config.include += $VAR_SUP_GRPC_BINARIES_DIR/\*\*
  }"
  # convert modified object back to JSON string
  NEW_FILE_CONTENT=$(powershell.exe -Command "ConvertTo-Json \$env:JSON_OBJ -Depth 100")
  # write new content back to file
  export NEW_FILE_CONTENT
  powershell.exe -Command "Set-Content .vscode/c_cpp_properties.json \$env:NEW_FILE_CONTENT"

  # Get the value of the Project from CMakeCache.txt
  VAR_NEW=$(powershell.exe -Command "Get-Content build/CMakeCache.txt | Select-String 'SUP_PROJECT_NAME:STRING' | ForEach-Object { \$_.Line } | ForEach-Object { \$_ -replace 'SUP_PROJECT_NAME:STRING=','' }")
  echo "\n [-----SETUP-----] Retrieved VAR_NEW $VAR_NEW"
  VAR_OLD=$(powershell.exe -Command "Get-Content build/CMakeCache.txt | Select-String 'SUP_PROJECT_NAME_old:STRING' | ForEach-Object { \$_.Line } | ForEach-Object { \$_ -replace 'SUP_PROJECT_NAME_old:STRING=','' }")
  echo "\n [-----SETUP-----] Retrieved VAR_OLD $VAR_OLD"

 # Find all files in the repository and replace the string
 #powershell.exe -Command "Get-ChildItem -Recurse | Where-Object { \$_.PSIsContainer -eq \$false } | ForEach-Object { (Get-Content \$_.FullName) | ForEach-Object { \$_ -replace \"$VAR_OLD\", \"$VAR_NEW\" } | Set-Content \$_.FullName }"

 ## Find all files in the repository and replace the string
 #powershell.exe -Command "Get-ChildItem -Recurse | Where-Object { \$_.PSIsContainer -eq \$false } | ForEach-Object {
 #  (Get-Content \$_.FullName) | ForEach-Object {
 #    \$_ -replace "$VAR_OLD", "$VAR_NEW"
 #  } | Set-Content \$_.FullName
 #}"

 ## Rename VAR_OLD_protocol.proto to VAR_NEW_protocol.proto
 #powershell.exe -Command "Rename-Item "utils/\$VAR_OLD_protocol.proto" "utils/\$VAR_NEW_protocol.proto""

fi