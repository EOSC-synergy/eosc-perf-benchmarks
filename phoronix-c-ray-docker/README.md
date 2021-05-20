## C-ray from phoronix test suite

Adapter image to run phoronix test suite tests (specifically c-ray) as a more or less headless image and provide a result.json for use with
eosc-perf.

To run the current release:
1. `mkdir out`
1. `docker run -v $(pwd)/out:/out_dir thechristophe/openbench-c-ray`
1. The result.json should now be in ./bench_out

To run a development build:
1. `docker build -t eosc-bench .`
1. `mkdir out`   
1. `docker run -v $(pwd)/out:/out_dir eosc-bench`
1. The result.json should now be in ./bench_out

To change benchmark:
1. Edit `BENCHMARK` in `entry.sh` to the phoronix test suite
1. (Optional) Collect any additional relevant data about the machine in `extract_and_add_meta.py`
