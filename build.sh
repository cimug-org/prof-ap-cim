#!/bin/env bash

rm -rf _docs
mkdir -p _docs/modules/ROOT/{attachments,pages,examples,images}
echo "name: $(yq .name src/prof_ap_cim.linkml.yml)" >> _docs/antora.yml
echo "version: '$(yq .version src/prof_ap_cim.linkml.yml)'" >> _docs/antora.yml
echo "title: $(yq .title src/prof_ap_cim.linkml.yml)" >> _docs/antora.yml

jinja2 src/prof_ap_cim.adoc.jinja2 src/prof_ap_cim.linkml.yml -o _docs/modules/ROOT/pages/index.adoc

cp \
    src/prof_ap_cim.linkml.yml \
    src/prof_ap_cim.shacl.ttl \
    src/prof_ap_cim.context.jsonld \
_docs/modules/ROOT/attachments

cp \
    src/examples/diagram_layout_ap.yml \
    src/examples/diagram_layout_ap.jsonld \
_docs/modules/ROOT/examples

cp src/prof_ap_cim.uml.svg _docs/modules/ROOT/images

npx antora antora-playbook.yml