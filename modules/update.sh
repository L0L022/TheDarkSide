#!/bin/bash
cd modules
rcc --project | sed 's|\.\/|modules/|g' > ../modules.qrc
