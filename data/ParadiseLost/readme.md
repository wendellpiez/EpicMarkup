
# Paradise Lost Book I by John Milton

## LMNL by extraction.

Run the pipeline [../../run/PRODUCE_PARADISE-LOST_LMNL.xpl](../../run/PRODUCE_PARADISE-LOST_LMNL.xpl) to generate full-fledged LMNL markup of Book I of the epic melodrama by John Milton, the revised edition of 1674. The pipeline reads the [HTML source file in this directory](c0_Paradise_Lost__1674__Book_I.xhtml) and writes a LMNL result file alongside it, [book01_rich.lmnl](book01_rich.lmnl).

By 'full-fledged', our feathering includes markup for these features and phenomena:

- Verse paragraphs and lines of verse
- Direct quotes as attributed to speakers ('quote' markup)
- Sentence/phase demarcations

Especially the overlap between the first and last of these structures is interesting.

## The author's intent

Indeed we have Milton's own word that the relation between verse structure and grammatical phrasing matters (in the introductory remarks defending blank verse):

> Not without cause therefore some both Italian and Spanish Poets of prime note have rejected Rime both in longer and shorter Works, as have also long since our best English Tragedies, as a thing of it self, to all judicious eares, triveal and of no true musical delight: which consists only in apt Numbers, fit quantity of Syllables, and **the sense variously drawn out from one Verse into another**, not in the jingling sound of like endings, a fault avoyded by the learned Ancients both in Poetry and all good Oratory."

(emphasis added)

## TODO

Next step: a Book I range map.

Beyond that: subsequent books (for 12 total)?

NB - the main question is whether and how the iXML grammar parsing s/phr structures holds up in the face of new inputs.

## Generalizable rules around English poetry

Very interested in the limits and in how the words of other poets fare, when we start attending to their work with the buzzsaw of markup that allows overlap.

These processes are not providing markup around Milton's rhetorical tropes - similes, comparisons and the rest. It is not difficult to envision.

## Known limits

The grammar provided for inferencing of `s/phr` (sentence/phrase) structures in English is fallible, likely to require adjustment for new inputs.

The data source is a clean copy derived from public (PD) data. It can be switched out for any (plain text or HTML) input, with adjustments.

Adjustments can serve also to make this useful to other workflows in which LMNL may be embedded.

## Range maps

TODO: DEVELOP range maps

-----

