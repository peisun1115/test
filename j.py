#!/usr/bin/env python

import json
import sys
import copy

def repeat(json_file, out_json, num):
    with open(json_file) as infile:
        data = json.loads(infile.read())
        microbench = data['run'][0]['test-suite']['microBench'][0]
        data['run'][0]['test-suite']['microBench'] = []
        name_prefix = microbench['name']
        for i in range(num):
            tmp = copy.deepcopy(microbench)
            tmp['name'] = "".join([name_prefix, "_", str(i)])
            tmp['config']['workDir'] = "".join([name_prefix, "_", str(i)])
            data['run'][0]['test-suite']['microBench'].append(tmp)
        with open(out_json, 'w') as outfile:
            json.dump(data, outfile, indent=4, sort_keys=True)

if __name__ == '__main__':
   repeat(sys.argv[1], sys.argv[2], int(sys.argv[3]))
