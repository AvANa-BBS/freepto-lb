#!/usr/bin/env python3
# Enumerate available xkb layouts

import lxml.etree

repository = "/usr/share/X11/xkb/rules/base.xml"
repository_file = open(repository, "r")
tree = lxml.etree.parse(repository_file)
layouts = tree.xpath("//layout")

f = open("i18n/keymaps","w")
for layout in layouts:

    layoutName = layout.xpath("./configItem/name")[0].text
    description = layout.xpath("./configItem/description")[0].text.replace(" ", "_")
    f.write("%s %s off\n" % (layoutName, description))

    for variant in layout.xpath("./variantList/variant/configItem"):
        name = variant.xpath('./name')[0].text
        description = variant.xpath('./description')[0].text.replace(" ", "_")	
        f.write("%s_%s %s off\n" % (layoutName, name, description))
