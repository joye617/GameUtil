#!/bin/bash
key=J0ycast1e
sign=joycastle

mv src src_bak
mkdir src
$QUICK_V3_ROOT/quick/bin/compile_scripts.sh -i src_bak -o src -m files -e xxtea_chunk -ek ${key} -es ${sign}

cd gameplugin/lua
mv gameplugin gameplugin_bak
mkdir gameplugin
$QUICK_V3_ROOT/quick/bin/compile_scripts.sh -i gameplugin_bak -o gameplugin/ -m files -e xxtea_chunk -ek ${key} -es ${sign}
cd ../..

# cp -r res res_bak
# exclude=sounds,particles,shaders,gaf,configs
# $QUICK_V3_ROOT/quick/bin/pack_files.sh -i res -o res -x ${exclude} -ek ${key} -es ${sign}
