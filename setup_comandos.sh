#!/bin/sh

mix deps.get
cd assets/
npm install
cd ..

echo "Para rodar em modo iex, executar: "
echo "iex -S mix phx.server"

