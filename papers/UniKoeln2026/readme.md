# What Can We See When We Can See Overlap?

University of Cologne<br class="br"/>
[Colloquium in Digital Cultural Heritage](https://lehre.idh.uni-koeln.de/lehrveranstaltungen/wintersemester-2026-2027/colloquium-in-digital-cultural-heritage/)<br class="br"/>
18 November 2026

## Presentation Slides

Take a look at the [PDF slides](../DeclarativeAmsterdam2026/DA2026-wendellpiez-slides.pdf) from Declarative Amsterdam 2026.

## In more depth ...

### Topics for more discussion

- Applications - actual, planned and potential
  - [Range maps](../../data/Iliad/rangemaps)
  - [Illuminated Iliad](../../data/Iliad/illuminated) and the [MYTHOI XML](../../data/Iliad/mythoi) model (target for MNML LMNL EpicMarkup)
- Whitespace and tagging - slipperiness of LMNL tags
- Hierarchies and layers
- Internals of xMNML vs LAYERS
- Example pipeline(s) in detail?
- Homer's *Iliad*:
  - Units of measure - feet, lines, phalanxes ...
  - "Wave form" structural principle: beginning-middle-end
  - Nested (mini) narratives and 'tales'
  - Similes
  - Echoes and songs

### How To Do It (summary)

While setup can be a chore and a challenge (for those not experienced with developer tools), creating data with interesting LMNL markup should be straightforward enough.

Developing new applications for it will then be the familiar effort of analysis, imitation, experiment and iteration, until things work.

Join with colleagues and share what you learn, to make it easier.

To proceed with LMNL, EpicMarkup and the Laminator, you should be reasonably comfortable ...

1. Installing and configuring software on your system
2. Working with `git` and git repositories (with submodules)
3. Working with XML - and XSLT and XProc - versions 3.0/3.1

### Steps

<details>
<summary>Look at examples</summary>

- Epic Markup examples from Homer and Milton in this repository
- More examples in the Laminator repository

</details>

<details>
<summary>Plan a goal</summary>

Optimally, your goal will be:

- Relevant to your interests
- Grand enough to be worth the struggle
- Modest enough to be easily accomplished

Keep in mind you can start with a small goal that leads to larger goals.

Your goal should be specific enough that you will know definitively when it has been accomplished. (And you can set a new goal.)

Any goal will work, whether focused on literature, applications of markup, or electronic media, as long as you can envision how LMNL and overlapping markup will support it.

</details>

<details>
<summary>Download and install an XProc 3 engine</summary>

  Pipelines have been tested with both XML Calabash and Morgana XProc IIIse: take your pick. Follow instructions on installing

- [XML Calabash](https://www.xmlcalabash.com/)
- [Morgana XProc IIIse](https://www.xml-project.com/morganaxproc-iiise.html)

Alternatively, use the conformant XProc 3 engine of your choice - it should work if it supports the [p:invisible-xml](https://spec.xproc.org/main/ixml/#c.invisible-xml) step.

Both of these processors require Java. (Other processors may have other dependencies.) If you already have it on your system, `java --version` on the command line will give satisfactory results. For example, the developer has Java OpenJDK on a Linux machine, and sees:

```
$ java --version
openjdk 25.0.4.1 2026-08-18
OpenJDK Runtime Environment (build 25.0.4.1+1-1-24.04.4-Ubuntu)
OpenJDK 64-Bit Server VM (build 25.0.4.1+1-1-24.04.4-Ubuntu, mixed mode, sharing)
```
**XML Calabash** requires at least Java 11.

**Morgana XProc IIIse** requires at least Java 8.

Java 17 and 25 have also both been seen to work well.

Either processor comes with simple pipelines to test your installation, or ask for help.

</details>


<details>
<summary>Download, clone or fork EpicMarkup</summary>

A zipped copy of the repository can be downloaded from https://github.com/wendellpiez/EpicMarkup/archive/refs/heads/main.zip.

A clone can be acquired with git from the command line like so:

```
> git clone https://github.com/wendellpiez/EpicMarkup.git
```

  Place a copy of the EpicMarkup repository on your system.
  https://github.com/wendellpiez/EpicMarkup.git

  Whether you want a simple copy (download), a clone (i.e., a copy under git version control), or a fork (a copy in a repository from which you can update the main repository) depends on what you plan to do with your code.

  If you keep the repository under version control (recommended if you want to update more easily), you will need to **initialize the `lib/Laminator` submodule**.
  
</details>

<details><summary>Choose and configure a text editor</summary>

Any plain-text editor supporting UTF-8 encoding will work.

Specialized support for LMNL can typically be configured to run as (a small set of) external commands from a programmer's text editor.

Alternatively, edit your tagged document using any editor, be sure it is saved as plain (unformatted) UTF-8, and use the tools from the command line to validate and process your files.

Take a look at the [extras](../../extras) folder for more information on setting up editors with syntax coloring and tools for LMNL and Epic Markup.

</details>

<details><summary>Examine, run and test production pipelines</summary>

[The `run` directory](../../run) contains pipelines that can be executed standalone, typically producing HTML or plain text outputs from LMNL inputs.

Inspect the pipelines to see what data sources they access (or require) and what they produce.</details>

<details><summary>Examine, test and run validation pipelines</summary>

Validation pipelines for LMNL can work at different levels, either testing just the minimum (syntactic well-formedness) or also testing higher-order rules around permitted range types, annotations, where overlap should (not) be tolerated, and so forth. Several pipelines in the repository demonstrate several kinds of such testing.

When LMNL is cast into XML, the XML can also of course be validated using normal means (RelaxNG, Schematron, XSLT etc.).

</details>

## Ways to Help

1. Create and test MNML LMNL
2. Imitate, adapt, or innovate LMNL processing - take cues from demonstrations or ask for assistance
3. Develop and document functional requirements for MNML LMNL applications
4. Read and critique the specification documents in the repository
5. Document your work so others can learn from it
7. Help develop unit tests
8. Gently draw attention to where these instructions can be improved


</details>
