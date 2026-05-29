#!/usr/bin/env python

from itertools import chain
import json
import yaml
import sys

from pyoxigraph import Dataset, parse, RdfFormat, serialize, Quad, NamedNode


def parse_yamlld(fp):
    with open(fp) as f:
        y = yaml.safe_load(f)
    j = json.dumps(y)
    qs = [Quad(q.subject, q.predicate, q.object, NamedNode(f"https://cim.ucaiug.io/{fp}")) for q in parse(j, format=RdfFormat.JSON_LD)]

    return qs
    

if __name__ == "__main__":
    prof_dataset = Dataset(chain(parse_yamlld("prof_ap_cim.prof.yml"), parse_yamlld("prof_ap_cim.skos.yml"), parse_yamlld("prof_ap_cim.shacl.yml"), parse_yamlld("prof_ap_cim.rdfs.yml")))
    #prof_dataset = Dataset(chain(map(parse_yamlld, ["prof_ap_cim.prof.yml", "prof_ap_cim.shacl.yml", "prof_ap_cim.rdfs.yml", "prof_ap_cim.skos.yml"])))

    serialize(prof_dataset, "prof_ap.jsonld", format=RdfFormat.JSON_LD)
