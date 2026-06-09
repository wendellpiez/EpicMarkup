# LMNL data directory

For safekeeping, LMNL sawtooth syntax variants of the Iliad are saved here:

## Generated programmatically

[PerseusDL_src](./PerseusDL_src/) - serializing directly from distributed source data (TEI XML)
[enhanced](./enhanced/) - the same data, except with some modifications and improvements.


Run the pipeline ../../../run/PRODUCE-LMNL-ILIAD.xpl to produce these sources.

Note that to keep the repository uncluttered files should not be simply deleted, but also removed from git.

[edited](./edited/) - more enhancements, these done by hand - includes MYTHOI markup.

## Edited by hand

How to edit LMNL tagging? An XML IDE doesn't give much help. But a plain text editor works fine, with care. Just be sure you maintain everything in Unicode.

The Laminator submodule repository offers a little support for editing LMNL syntax in TextPad, the Windows text editor for Windows.

## MYTHOI tagging

Ranges marking the text for phenomena, properties or relations not given in the text itself can now be marked even when they overlap and despite any schema.

This makes *exploratory markup* viable and rewarding in ways the XML feature set frustrates. A document can be tagged and then a schema can be derived, rather than having to codify the markup so early.

Tags in this tag set atm include `scene`, `speech`, `tale` (for nested narrative) and others.