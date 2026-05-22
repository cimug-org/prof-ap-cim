#!/bin/env bash

jinja2 src/prof_ap_cim.adoc.jinja2 src/prof_ap_cim.linkml.yml \
    | tee docs/index.adoc \
    | asciidoctor -a stylesheet=src/cimug.style.css -o docs/index.html -r rouge -

cp \
    src/prof_ap_cim.linkml.yml \
    src/prof_ap_cim.shacl.ttl \
    src/prof_ap_cim.context.jsonld \
    src/prof_ap_cim.uml.svg \
docs/