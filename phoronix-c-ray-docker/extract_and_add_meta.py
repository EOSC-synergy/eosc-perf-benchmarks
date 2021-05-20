import argparse
import json
import sys

from cpuinfo import get_cpu_info


def main():
    parser = argparse.ArgumentParser(description="Restructure and fill in phoronix benchmark jsons")
    parser.add_argument("in_file", type=str, help="The input file.")
    parser.add_argument("result_name", type=str, help="The name of the result.")
    args = parser.parse_args()

    # read results json
    with open(args.in_file, "r") as in_file:
        contents = in_file.read()
        try:
            in_data = json.loads(contents)
        except json.JSONDecodeError as e:
            print("Unable to parse input JSON!", file=sys.stderr)
            print(contents, file=sys.stderr)

    # extract data from phoronix format to single result format
    # assume only one result in file
    # { "results": {all_data} } => {all_data}
    data = in_data["results"][0]
    # { "results": { "result_name": {result_data}} => {"result": {result_data}}
    data["result"] = data["results"][args.result_name]
    data.pop("results")

    data["result"]["score"] = float(data["result"]["score"])

    # optional additional relevant data (e.g. CPU info for c-ray)
    data["machine"] = {}
    data["machine"]["cpu"] = get_cpu_info()

    # write resulting data
    print(json.dumps(data, indent=4, sort_keys=True))


if __name__ == "__main__":
    main()
