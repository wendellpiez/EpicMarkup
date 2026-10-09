# Some Background on LMNL

(Retrospective August 2026, with later revisions)

XML was published in late 1998. By 2002 we suddenly had many new tools: HTML and CSS were bringing us declarative markup and layered styling on the web; browser developers were beginning to provide DOM access to pages and their structures; and above all, XML made it possible (as a friend of once mine said) "never to have to write a parser again". (It turns out he was wrong, but he was right before he was wrong -- and now he is right again.)

One of the new ideas of 2002 -- even then, an old idea, but in a new context -- was LMNL, a markup language and syntax developed and proposed by Jeni Tennison and myself. LMNL was inspired directly by the work of Gavin Thomas Nicol on range algebras. This was a time before Markdown and JSON were widespread or even well known; both wiki technology and in-browser page scripting were in their infancy, and even to many web developers the idea of a DOM was still new. The future was coming, but at an uneven pace: XML was recently ascendant but still contested, and broad-ranging conversations were first bringing together, for developers, concepts about *modeling* and *markup*. Early in that year, for a paper at the Extreme Markup Languages Conference in Montreal (now vanished into the grey literature), Gavin Nicol offered the idea of a *range algebra*, a kind of Invisible XML before its time. In peer reviewing the paper, Jeni had taken note of the generality of this idea, while at the same time she and I were exchanging ideas about markup (applications and modeling) in correspondence; quickly we adapted Gavin's ideas about ranges (contiguous runs of characters that could be named and compared) to describe a single universal data model for documents that could, like XML, be externalized and accommodated (we thought) by a markup syntax serialization. This became a pair of linked proposals which together we called LMNL, the Layered Markup and Annotation Language.

In subsequent years, at the Extreme Markup Languages Conference series (which eventually became Balisage), in Digital Humanities venues and elsewhere, as a loose coalition we presented LMNL mainly in the form of conceptual *demonstrations* of capability, sometimes awkwardly using available tools in unprescribed ways. "We" soon included John Cowan and other enthusiasts who felt the ideas were good enough to subject to proof. (In doing this, of course, we were also sketching use cases and laying testbeds for new requirements to be addressed by new features and capabilities in the tools, with immensely profitable results.) In this we were also supported by competing initiatives seeking similar or different solutions to the same problems, led and joined by great scholars and leading technologists who made room for discussion and debate. The problem set, of course, goes by the name of "Overlap".

 The greater inspiration for LMNL, of course, was XML itself, specifically as a refinement of SGML: like XML (and SGML), LMNL sought to be *generalized*; like XML (and unlike SGML) LMNL made a clear distinction between its syntax of representation (markup as syntax and notation, tags and text), and its data model.

As described at the [First International Symposium on iXML](https://invisiblexml.org/events/symposium2026/#slides)([with paper](https://github.com/wendellpiez/Laminator/tree/main/papers/iXMLSymposium2026)), this story seemed over, until it didn't. Even while better tools in the XML stack had eased the problems of developers designing for and supporting a familiar set of overlap-related requirements, seemingly at once, the doors opened again to a viable implementation of a LMNL processing stack, using XProc, iXML and XSLT 3.0. I undertook this project (my second LMNL processor) in late 2025: the **Laminator**.

During this period I learned from everyone else who also looked at the beast. Many of their initiatives and proposed solutions are reflected in the work being offered. Similarly, many of the XML "usual tricks" around overlap -- milestones, segmenting, standoff -- can be readily accommodated by the Laminator as inputs and in its (XML) productions.

## 2026 Perspective

Problems that result directly from a design feature of a technology (such as a language or metalanguage) -- in this case, XML's element hierarchy -- tend to take many different forms and to be more or less severe or troublesome, given the case. Today (2026) overlap in markup languages, including XML-based tagging languages, is not perceived as a problem, both because workarounds and mitigations are better known, and because we are better at anticipating the issues and finding ways to avoid or work around them. (What seems awkward eventually becomes acceptable after doing it a few times.) This leaves a smaller number of initiatives -- notably, those interested in overlap *per se* (perhaps in the context of literary studies) -- with no really good solutions, just manageable ones.

At the same time, being able to thread this particular needle and make LMNL markup "work" (to some definition) is personally gratifying, however small and human-scaled the demonstration.

Two developments make it feasible now. The XML toolchain - parsers, processors, interfaces - is stable and offers capabilities not available 20 years ago. Secondly: I have learned so much! so for example, the current initiative does not try to embrace all of LMNL (whose features were never finalized in any case), but focuses instead on capabilities specifically able to support the research I am doing, specifically with respect to the rhetorical features and narrative structures of ancient epic literature.

Welcome to the games --!

*Expressing my sincere gratitude*<br class="br"/>
is the only answerable attitude<br class="br"/>
I could bring<br class="br"/>
to the entire overlap thing.

Critical developments in XML tools 2010-2025, enabling the Laminator:

 - XSLT 3.0/3.1 - accumulators and other useful features

 - XProc 3.0 - introduced capability of reading and writing text-based syntaxes, not just XML (among other features)

 - iXML (invisible XML) - providing a grammar-based parser solution that superseded earlier hand-coded XSLT parsing (via sibling recursion) - more robust, cleaner, easier to test

-- Wendell Piez, October 2026

---
