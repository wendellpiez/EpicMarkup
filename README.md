# Epic Markup

Epic poetry - Homer's Iliad - with LMNL markup: overlapping hierarchies on an XML/XProc/XSLT/TEI platform

<details><summary>What is LMNL</summary>
LMNL is the Layered Markup and Annotation Language, which defines a markup syntax and a data model designed to support data processing over text (expressed in Unicode).

Think of it as similar to XML, except:

- Different syntax for tags
- Permits spans of tagged text to overlap one another (tagging 'does not always nest')

```
[book [n}1{]}
[para}[l [n}1.1{]}[phr}μῆνιν ἄειδε θεὰ Πηληϊάδεω Ἀχιλῆος{l]
[l [n}1.2{]}οὐλομένην,{phr] [phr}ἣ μυρίʼ Ἀχαιοῖς ἄλγεʼ ἔθηκε,{phr]{l]
[l [n}1.3{]}[phr}πολλὰς δʼ ἰφθίμους ψυχὰς Ἄϊδι προΐαψεν{l]
[l [n}1.4{]}ἡρώων,{phr] [phr}αὐτοὺς δὲ ἑλώρια τεῦχε κύνεσσιν{l]
[l [n}1.5{]}οἰωνοῖσί τε πᾶσι,{phr] [phr}Διὸς δʼ ἐτελείετο βουλή,{phr]{l]
[l [n}1.6{]}[phr}ἐξ οὗ δὴ τὰ πρῶτα διαστήτην ἐρίσαντε{l]
[l [n}1.7{]}Ἀτρεΐδης τε ἄναξ ἀνδρῶν καὶ δῖος Ἀχιλλεύς.{phr]{l]{para]
...{book]
```

More examples can be found in the [Laminator repository](https://github.com/wendellpiez/Laminator/tree/main/sources/Luminescent)

</details>

*Winged Words*: Some preliminary research results can be seen in the [data/Iliad/rangemaps](data/Iliad/rangemaps) folder.

Planned: some project results will be published on the developer's [Raven Tracks portal](https://raventracks.org) alongside other resources and projects.

## Cloning the repository

To run the processes for yourself: all the pipelines in the repository should run in a conformant XProc 3.0/3.1 engine. Some pipelines require MarkupBlitz (bundled with XML Calabash). For ease of use, the pipelines are set up like scripts, which can be executed 'standalone', i.e. without configuring any bindings or dependencies.

This project uses the Laminator for LMNL processing (see below).

When cloning this repository use `--recurse-submodules`, or to set up the submodule:

```
> git submodule init
```

And

```
> git submodule update
```

(Or your preferred method.)

The latter command can be used alone to refresh (update) the submodule after it has been initialized.

See the [`lib` folder](./lib/readme.md) for submodules.

## Coming attractions

- [x] XProc pipeline to acquire and archive a copy of the open-source PerseusDL TEI Iliad (edition of Monro and Allen, encoded by Crane et al.)
- [x] XProc pipeline to convert the TEI XML to LMNL
- [x] *Iliad*, encoded in LMNL "sawtooth" syntax ("PerseusDL TEI LMNL")
- [ ] A design for MYTHOI tagging (TEI tagging of narrative and rhetorical structures)
- [ ] An enhanced version of the epic, also in LMNL, using MYTHOI tagging
     - Books 1 and 2 so far 
- [ ] Αn XProc pipeline for producing TEI XML from LMNL (MYTHOI, TEI or other)
- [x] An Xproc pipeline for producing 'Range Map' visual renditions of the epic and its parts
- [ ] (Maybe) an XProc pipeline for producing a dynamic *Iliad Illuminated* web publication

## Acknowledgements

This work builds on foundations laid by others:

- Perseus project and contributors - for PerseusDL source data
- XProc developers and community
- TEI developers and community
- iXML developers and community

It is dedicated to everyone who believed in LMNL and everyone who has thoughtfully challenged it, with grateful thanks, as well as to the memory of that Titan of Markup, C. Michael Sperberg-McQueen.

## XProc 3.0

XProc 3.0 is a language defined by a standardized open specification, used to describe simple and complex operations - to "define jobs" - to be performed over XML or other data (including HTML, JSON, plain text and other formats). These operations include both transformations (using XSLT and other means) and interactions with the system, such as reading, writing, segmenting and merging resources.

Think of XProc as a document- and data-oriented 'build' language. You can learn more about it on the Internet, or see another project by the developer, the [XProc Zone](https://xproc.zone).
## Laminator

The Laminator is a library written by the developer to handle a useful subset of LMNL, MNML. MNML sacrifices some of the useful features of LMNL in favor of an implementation of core functionality -- annotating ranges with markup, including overlapping ranges -- that is much easier to design and test for its simplicity. MNML LMNL is **Minimally Annotated Markup in LMNL**.

[The Laminator](https://github.com/wendellpiez/Laminator/)  is included with the project as repository submodule. While the Laminator supports only a subset of LMNL, it is entirely generic and agnostic with respect to vocabularies used for tagging; this permits this project to stick close to [TEI](https://tei-c.org) as a *lingua franca*.

## Editing LMNL

If you have gotten this far, possibly you will be glad to know you can edit LMNL in a text editor with some dedicated tooling and syntax coloring.

TODO: details and files for TextPad

===
20260607
