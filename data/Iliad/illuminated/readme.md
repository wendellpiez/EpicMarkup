# ILIAD ILLUMINATED

## Homer's Iliad in an Analytical View

### Produced with the help of LMNL markup

Ancient Greek text in the Oxford edition of 1920
(kindly provided by PerseusDL)

Rendered into web pages for your enjoyment and study.

Provided with morphological analysis and vocabulary also acquired gratefully from open source Classics resources on line (Scaife, PerseusDL treebank).

See the pages by opening any page in the Github previewer. *Hint:* if you see nothing special (and it's all Greek to you), try checking **Illuminate** at the top of the page. 

[Book 1 ](https://htmlpreview.github.io/?https://github.com/wendellpiez/EpicMarkup/blob/main/data/Iliad/illuminated/ILIAD-illuminated_book01.html) [Book 2 ](https://htmlpreview.github.io/?https://github.com/wendellpiez/EpicMarkup/blob/main/data/Iliad/illuminated/ILIAD-illuminated_book02.html) [Book 3 ](https://htmlpreview.github.io/?https://github.com/wendellpiez/EpicMarkup/blob/main/data/Iliad/illuminated/ILIAD-illuminated_book03.html) [Book 4 ](https://htmlpreview.github.io/?https://github.com/wendellpiez/EpicMarkup/blob/main/data/Iliad/illuminated/ILIAD-illuminated_book04.html) [Book 5 ](https://htmlpreview.github.io/?https://github.com/wendellpiez/EpicMarkup/blob/main/data/Iliad/illuminated/ILIAD-illuminated_book05.html)

## Q&A

### What is this, exactly?

The source text of the 1920 Oxford edition of Homer's epic in 24 books, as published by Perseus Digital Library (PerseusDL), is rendered with annotations provided by the developer. Currently five books are available, with more coming.

Annotations on the page are sourced from files using LMNL markup, making them easy and straightforward to produce and edit, within a well-controlled, declarative processing workflow, irrespective of complexities in their rendering.

The [LMNL source files](../lmnl/edited/) can be seen elsewhere in the repository.

The [XProc pipeline](../../../run/PRODUCE-ILIAD-ILLUMINATED.xpl) that produces this HTML+CSS+JS can also be found in the repository, making the process reproducible with these or other input data sets. (Execute the pipeline in an XProc engine supporting iXML. Remember to examine and understand any pipeline before running it.)

### How general is it?

Although tuned to Homer's Iliad, all the logic is very general, including all the logic of the pipeline that produces, first, [MYTHOI markup](../mythoi/), and then the HTML seen here, from MYTHOI as an intermediate form.

-----
20261026
