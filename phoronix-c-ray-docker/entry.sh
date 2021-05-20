#!/bin/bash

PHORONIX=/usr/bin/phoronix-test-suite

# the name of the test you want to run
BENCHMARK="c-ray"
# the "file" name for the result data
# note: this is not the file you get, this is the internal file in which PTS stores all results of a given test
# only use alphanumeric for this, other characters seem to get trimmed which breaks getting the json output
INTERNAL_FILE_NAME="resultdata"
# the name of the individual result
# this docker image is made to run only one test, so this should always be the single result
RESULT_NAME="test_result"
# the final output from phoronix test suite
OUT_DIR="/out_dir"
OUT_FILE="${OUT_DIR}/result.json"

# configure PTS
echo -e "Y\nN\nn\nY\nn\nY\nn\n" | ${PHORONIX} batch-setup
# run benchmark
echo -e "${INTERNAL_FILE_NAME}\n${RESULT_NAME}\n" | ${PHORONIX} batch-benchmark "${BENCHMARK}"
# store pts result
mkdir -p "${OUT_DIR}"
${PHORONIX} result-file-to-json "${INTERNAL_FILE_NAME}" > "${OUT_FILE}.tmp"
# restructure output json
python3 /extract_and_add_meta.py "${OUT_FILE}.tmp" "${RESULT_NAME}" > "${OUT_FILE}"
# echo json back to terminal in case files are inacessible
cat ${OUT_FILE}
# remove leftovers
rm "${OUT_FILE}.tmp"
