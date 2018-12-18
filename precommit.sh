#!/bin/bash
sed -i -e 's/\.\/\${_xil_proj_name_}/\.\/vivado_project/g' build.tcl
