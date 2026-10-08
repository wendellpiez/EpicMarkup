# Some Background on LMNL

(Retrospective August 2026, with later revisions)

XML was published in late 1998. By 2002 we suddenly had many new tools: HTML and CSS were bringing us declarative markup and layered styling on the web; browser developers were beginning to provide DOM access to pages and their structures; and above all, XML made it possible (as a friend of once mine said) "never to have to write a parser again". (It turns out he was wrong, but he was right before he was wrong -- and now he is right again.)

One of the new ideas of 2002 -- even then, an old idea, but in a new context -- was LMNL, a markup language and syntax developed and proposed by Jeni Tennison and myself. LMNL was inspired directly by the work of Gavin Thomas Nicol on range algebras. Inspired by his idea of capturing a text into *ranges*, where ranges consisted of contiguous runs of characters, we abstracted this into a conceptual model of a document not as a hierarchy of elements (such as a parser commonly delivers to an application) but more primitively, as a set of ranges defined over a text. (In some ways Nicol's range algebra was like iXML before its time.) The greater inspiration for LMNL, of course, was XML itself, specifically as a refinement of SGML: like XML (and SGML), LMNL sought to be *generalized*; like XML (and unlike SGML) LMNL made a clear distinction between its syntax of representation (markup as syntax and notation, tags and text), and its data model.

Over the course of some years, LMNL subsisted as a research project in the form of a standards development exercise, while we (proponents) wrote papers on or around it, and while others made and demonstrated proposed solutions of their own, to the set of problems LMNL was aimed at. The problem set, of course, goes by the name of "Overlap".

As described at the [First International Symposium on iXML](https://invisiblexml.org/events/symposium2026/#slides)([with paper](https://github.com/wendellpiez/Laminator/tree/main/papers/iXMLSymposium2026)), this story seemed over, until it didn't. Even while better tools in the XML stack had eased the problems of developers designing for and supporting a familiar set of overlap-related requirements, seemingly at once, the doors opened again to a viable implementation of a LMNL processing stack, using XProc, iXML and XSLT 3.0. I undertook this project (my second LMNL processor) in late 2025: the **Laminator**.

During this period I learned from everyone else who also looked at the beast. Many of their initiatives and proposed solutions are reflected in the work being offered. Similarly, many of the XML "usual tricks" around overlap -- milestones, segmenting, standoff -- can be readily accommodated by the Laminator as inputs and in its (XML) productions.

## 2026 Perspective

Problems that result directly from a design feature of a technology (such as a language or metalanguage) -- in this case, XML's element hierarchy -- tend to take many different forms and to be more or less severe or troublesome, given the case. Today (2026) overlap in markup languages, including XML-based tagging languages, is not perceived as a problem, both because workarounds and mitigations are better known, and because we are better at anticipating the issues and finding ways to avoid or reduce them. (What seems awkward eventually becomes acceptable after doing it a few times.) This leaves a smaller number of initiatives -- notably, those interested in overlap *per se* (perhaps in the context of literary studies) -- with no really good solutions, just manageable ones.

At the same time, being able to thread this particular needle and make LMNL markup "work" (to some definition) is personally thrilling, however small and "human-scaled" the demonstration.

*Expressing my sincere gratitude*<br class="br"/>
is the only answerable attitude<br class="br"/>
I could bring<br class="br"/>
to the entire overlap thing.

Critical developments in XML tools 2010-2025, enabling the Laminator:

 - XSLT 3.0/3.1 - accumulators and other useful features

 - XProc 3.0 - introduced capability of reading and writing text-based syntaxes, not just XML (among other features)

 - iXML (invisible XML) - providing a grammar-based parser solution that superseded earlier hand-coded XSLT parsing (via sibling recursion) - more robust, cleaner, easier to test

(Wendell Piez)

---
