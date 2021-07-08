#!/usr/bin/env python

# usage: python read_json_lockfiles.py github Renvs/*.lock | sort | uniq > list_of_packages_in_github.txt
# usage: python read_json_lockfiles.py cran Renvs/*.lock | sort | uniq > list_of_packages_in_cran.txt

import sys,json

#print("Name\tPackage\tVersion\tRepository")

repo=sys.argv[1]
cranpkg=open(repo, 'w')
githubpkg=open(repo, 'w')

for jsonfile in sys.argv[2:]:
	with open(jsonfile, 'r') as js:
		data = json.load(js)
		for package in data['Packages'].keys():
			if data['Packages'][package]['Source'] == "Repository" and repo=="cran":
				print(data['Packages'][package]['Package'])
			#	print("\t".join([package, data['Packages'][package]['Package'], data['Packages'][package]['Version'], data['Packages'][package]['Repository'] ]) )
			if data['Packages'][package]['Source'] == "GitHub" and repo=="github":
				print("\t".join([package, data['Packages'][package]['Package'], data['Packages'][package]['Version'], data['Packages'][package]['RemoteType'], data['Packages'][package]['RemoteRepo'], data['Packages'][package]['RemoteUsername']]) )
