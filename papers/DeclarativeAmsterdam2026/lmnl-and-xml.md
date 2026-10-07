
# LMNL and XML

Understanding LMNL through an XML lens is both understandable, and normal. The two are very different and distinct, while some important similarities also help to ground a comparison.

## Similarities

- Both provide for declarative tagging; define your own tagging (extensibility); adaptive schemas; late binding to schemas.

- Both syntaxes use the convention of to demarcate text ("tag" it) using start tags, end tags and "empties" (single tags in place, no start or end). Both XML and LMNL require start and end tags to pair up and for start tags to come before ends.

- LMNL follows XML in some of its lower-level rules such as rules around naming, for convenience in integrating with XML systems.

## Differences

**Difference** XML follows an *end-tag matching rule*, while LMNL syntax does not. This is so that LMNL tags can mark ranges, while XML tags mark the boundaries of an element tree.

**Difference** XML and LMNL syntax use different notations, so the tags look different.

XML:

```xml
<tagXML>...</tagXML>
```

versus LMNL tagging

```
[tagLMNL}...{tagLMNL]
```

**Difference** Where XML has *attributes*, LMNL has *annotations*. In MNML LMNL (the LMNL subset supported by Laminator), as in XML, these appear in the data model as name/value pairs (i.e., named properties), and values are always strings or datatypes expressible as strings.

In LMNL (but not implemented by Laminator), annotations can be entire LMNL documents, with structure and markup, and can have their own annotations.

The subset of LMNL implemented by the Laminator is MNML, for *Minimally Annotated Markup in LMNL*. Its specifications, with luck, can be found in the [Laminator repository](https://github.com/wendellpiez/Laminator) (a submodule of this repository).

**Difference**

XML is a syntax with an implicit data model.

LMNL is defined as a data model, with a syntax (called "LMNL syntax" or "sawteeth") proposed to go with it.

This difference makes little difference to users of LMNL tagging, but a big difference for developers.

The commonality is that in both XML and LMNL, syntax and model are conceptually distinct. It means, among other things, that LMNL could potentially resemble XML in one other important respect: alternative platforms and implementations are thinkable and viable for LMNL, and thus for its MNML subset.

## Exploratory Markup

It is easier to design models for documents using XML than using SGML, since SGML's requirement for a schema (DTD) prior to parsing a document effectively embedded the DTD into the modeling process, creating a chicken/egg problem. No document could exist before a schema was provided for it, at least nominally, in the form of its DTD.

XML improved on this situation by defining syntactic well-formedness: i.e., and subject to certain caveats (such as that all entities could be expanded), an XML document can be parsed definitively and deterministically without reference to a schema. So documents could be created -- and models designed -- with schemas offered only as a codification of what was known about a document set, not a definition of a document type. This is a subtle but important distinction.

LMNL goes a step even further. Because elements in XML must nest, a new element type cannot be introduced without considering its relation to the defined types already in place, with respect to containment. Where an element can be placed is dependent on where other elements are placed. In LMNL this is no longer the case. New markup for new range types can be introduced at any time for any reason, even when they conflict or compete, on either syntactic or semantic levels. Normalization can occur later.

This makes LMNL an advantage when we need to make it up as we go.

See the [Presentation Writeup](presentation-writeup.md) for more on this interesting topic.

## End-tag matching rule

What stood in the way of our doing this? 25 years ago, even while the XML technology stack made available unprecedented capabilities -- effectively for free, to those who knew how to identify, acquire and run the software -- we lacked high quality data to help jumpstart markup. Since transcription and interpretive markup, while two separate activities, are also inextricably interconnected, being able to adopt a good transcription makes two jobs into one. But there was one other big impediment to free-form markup for exploration, namely XML's end-tag matching rule (abbreviated 'ETMR' hereafter).

In effect, the ETMR means that a single tree of elements can be unambiguously distinguished, so with each element we can identify not only neighbor elements but contained and containing elements. More than just a name with qualified data points (attributes or annotations) associated with a value (a text range), an element also fixes its text in relation to all other elements and their text. With respect to text contents, any elements are either entirely discrete (with no contents in common), or clearly composed one inside the other. So in XML:

- Alpha precedes Beta when Alpha's end tag appears before Beta's start tag
- Epsilon follows Delta when Epsilon's start tag appears after Delta's end tag
- Otherwise, if Tau's start appears after Sigma starts but before it ends, we know (from the EMTR) Tau also ends before Sigma, and Sigma contains Tau.

It is possible to eliminate the end-tag matching rule and retain a rule (only) that each end tag must pair unambiguously with a start tag given prior to it. If we stipulate that this can be the most recent start tag with the same name, everything can be matched up; if we add to this a convention on representing a range ID on the tag, we can even provide for ranges of the same *type* name (generic identifier) to overlap one another ("sibling rivalry"), since their *tags* (type name plus identifier) do not match.

When the ETMR is *not* followed, as long as tags still appear in pairs, we have these categories plus another: ranges that *overlap*, one at the start, the other at the end.

At the same time, the question of what it means to "start before my start" or "end before my end" must also be clarified, with consequences for the model.

## Tags, tag order and text

Specifically, and somewhat counter-intuitively, since LMNL is constituted of the ranges not the tags, and since the ranges are ordered not intrinsically but by their offsets, when two or more tags appear adjacent, their order is *undefined*.

Applications accordingly may rewrite tags to place them in a nominally 'correct' or 'best' order (while *not moving them* by changing offsets), generally determined by criteria such as legibility and 'least surprise'.


Tag ordering in LMNL may appear sometimes to be "slippery", inasmuch that when they appear at the same offset (i.e., with no intervening space or characters), the order of tags may not be preserved in processing.

The easiest solution to this is simply to use whitespace or other data between tags, which has the effect of fixing their relative order.

Alternatively, define a normative set of ordering rules and enforce them with tag-rewriting operations.

-----
First written 2026. See the git repository for file history.

