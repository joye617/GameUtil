#!/bin/bash
rm -r src
mv src_bak src

cd gameplugin/lua
rm -r gameplugin
mv gameplugin_bak gameplugin
cd ../..

# rm -r res
# mv res_bak res
