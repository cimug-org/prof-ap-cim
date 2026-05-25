#!/bin/env bash

rm -rf docs-adoc
mkdir -p docs-adoc

for src_dir in src/*; do
    linkml=$src_dir/schema/prof_ap_cim.linkml.yml
    version=$(basename $src_dir)
    root_module=docs-adoc/$version/modules/ROOT

    mkdir -p $root_module/{attachments,images,pages}
    mkdir $root_module/attachments/examples

    echo "name: ROOT" >> $root_module/../../antora.yml
    echo "version: '$(yq .version $linkml)'" >> $root_module/../../antora.yml
    echo "title: $(yq .title $linkml)" >> $root_module/../../antora.yml

    jinja2 -o $root_module/pages/index.adoc $src_dir/prof_ap_cim.adoc $linkml

    cp \
        $linkml \
        $src_dir/schema/prof_ap_cim.shacl.ttl \
        $src_dir/schema/prof_ap_cim.context.jsonld \
    $root_module/attachments

    cp \
        $linkml \
        $src_dir/examples/diagram_layout_ap.yml \
        $src_dir/examples/diagram_layout_ap.jsonld \
    $root_module/attachments/examples
done

npx antora antora-playbook.local.yml
