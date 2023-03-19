#!/bin/bash
# ==============================================================================
# Copyright (C) 2018-2021 Intel Corporation
#
# SPDX-License-Identifier: MIT
# ==============================================================================

set -e

INPUT=${1:-https://github.com/intel-iot-devkit/sample-videos/raw/master/head-pose-face-detection-female-and-male.mp4}
OUTPUT=${2:-display} # Output type, valid values: display, json ,display-and-json 

PROC_PATH() {
    echo ./model_proc/$1.json
}

MODEL_D=face-detection-adas-0001
MODEL_C1=age-gender-recognition-retail-0013
MODEL_C2=emotions-recognition-retail-0003
MODEL_C3=facial-landmarks-35-adas-0002

PATH_D=./models/intel/face-detection-adas-0001/FP32/face-detection-adas-0001.xml
PATH_C1=./models/intel/age-gender-recognition-retail-0013/FP32/age-gender-recognition-retail-0013.xml
PATH_C2=./models/intel/emotions-recognition-retail-0003/FP32/emotions-recognition-retail-0003.xml


echo Running sample with the following parameters:
echo GST_PLUGIN_PATH=${GST_PLUGIN_PATH}

PYTHONPATH=$PYTHONPATH:$(dirname "$0")/../../../python \
python3 $(dirname "$0")/customer_tracking.py -i ${INPUT} -d ${PATH_D} -c1 ${PATH_C1} -c2 ${PATH_C2} -o ${OUTPUT}
