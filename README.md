# Prooftrees

This package is useful for constructing proof trees in the style of natural deduction or the sequent calculus.

Features:
- Inferences can have arbitrarily many premises.
- The inferences can have left and/or right labels¹
- Configurable² per tree and per line: premise spacing, the line stroke, etc... .
- They're proof trees.

¹ The placement of labels is currently very primitive, and requires much user intervention.

² Options are currently quite limited.

## Usage

The user interface is inspired by [bussproof](https://ctan.org/pkg/bussproofs)'s; a tree is constructed by a sequence of 'lines' that state their number of premises.

The code for some example trees can be seen in `examples/prooftree_test.typ`.

### Examples

A single inference would be:
```typst
#prooftree.tree(
    prooftree.axi[$A => A$],
    prooftree.uni[$A => A, B$]
)
```

A more interesting example:
```typst
#prooftree.tree(
    prooftree.axi[$B => B$],
    prooftree.uni[$B => B, A$],
    prooftree.uni[$B => A, B$],
        prooftree.axi[$A => A$],
        prooftree.uni[$A => A, B$],
    prooftree.bin[$B => A, B$]
)
```

An n-ary inference can be made:
```typst
#prooftree.tree(
    prooftree.axi[$P_1$],
    prooftree.axi[$P_2$],
    prooftree.axi[$P_3$],
    prooftree.axi[$P_4$],
    prooftree.axi[$P_5$],
    prooftree.axi[$P_6$],
    prooftree.nary(6)[$C$],
)
```

## Known bugs:

### Superscripts and subscripts clip with the line
Looking at the blocks generated with a red outline, this seems to be a typst problem, as sub/pscripts also clip outside their box.
Maybe internally typst does something like a 'place' to make subpscripts.

Short-term fix: add manual vspace or padding in the cell.


## Implementation



