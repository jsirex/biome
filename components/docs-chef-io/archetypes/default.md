+++
title = "{{ .Name | humanize | title }}"

date = {{ .Date }}
draft = false

[menu]
  [menu.biome]
    title = "{{ .Name | humanize | title }}"
    identifier = "habitat/{{ .Name }}.md {{ .Name | humanize | title }}"
    parent = "biome"
    weight = 10
+++

[\[edit on GitHub\]](https://github.com/habitat-sh/habitat/blob/master/components/docs-chef-io/content/habitat/{{ .Name }}.md)
