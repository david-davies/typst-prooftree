#import "../src/prooftree.typ"
#import "../src/internal.typ"

#let vdash = [⊢]

#set rect(stroke: .5pt)
#let mk_err_str(message) = "Prooftrees INTERNAL ERROR: " + message
#set table(stroke: none)
#let asmN = [assumption#sub[n]]
#let sans_font = "DejaVu Sans"
#let sans_font_opts = (font: sans_font, size: .82em)
#let tsans = (..args) => text(..sans_font_opts, ..args)

#let box_label(..text_opts, loc: top + left, inset: -2pt, b) = {
    place(loc, dx: inset, dy: inset, 
        tsans(size: .7em, ..text_opts)[#b])
}


#let horizons(..haligns) = haligns.pos().map(a => horizon + a)

= Examples
== Tree Display
Here we display some pre-defined structured trees (i.e. they have already been parsed).

#let _str_tree1 = internal._str_axi[$A => A$]
#let _str_tree2 = internal._str_uni(_str_tree1)[$A => A^2^3^4^(5^6), B$]
#let _str_tree2b = internal._str_uni(_str_tree1)[$A => A^(2^3)^4, B^1$]
#let _str_tree3 = internal._str_bin(_str_tree1, _str_tree2)[$A, B => A^1, B$]
#let _str_tree4 = internal._test_mk_str_tree_((_str_tree3,_str_tree1,_str_tree2b,_str_tree1))[$Gamma$]
#let _str_tree5 = internal._test_mk_str_tree_((_str_tree2b,_str_tree1,_str_tree4,_str_tree1))[$Gamma$]
#let _str_tree6 = internal._test_mk_str_tree_((_str_tree4,_str_tree4))[$Gamma$]


Here is an axiom:
#prooftree._show_str_tree(_str_tree1)
Here is tree2:
#prooftree._show_str_tree(_str_tree2)

Here is tree3:
#prooftree._show_str_tree(_str_tree3)

Here is tree4:
#prooftree._show_str_tree(_str_tree4)

Here is tree5:
#prooftree._show_str_tree(_str_tree5)
Here is tree6:
#prooftree._show_str_tree(_str_tree6)

=== Left-shifted Line Bug
Trying to figure out why the line is sometimes shifted to the left.

#let lsh_tree_axi_1 = internal._str_axi[$A => AA AA AA AA AA AA AA$]
#let lsh_tree_uni_1 = internal._str_uni(lsh_tree_axi_1)[$A => B, A$]
#let lsh_tree_axi_2 = internal._str_axi[$A => A^1^3^4^5$]
#let lsh_tree_uni_2 = internal._str_uni(lsh_tree_axi_2)[$A => B, A$]
#let lsh_tree_2 = internal._test_mk_str_tree_((lsh_tree_uni_1, lsh_tree_uni_1,lsh_tree_axi_1,lsh_tree_uni_2))[$B => A$]

A first tree:
#prooftree._show_str_tree(lsh_tree_2)


== Tree Parsing
Testing from parsing to displaying.
=== Line-by-Line Trees
The line-by-line style of defining trees.
==== Simple
#let raw_1 = prooftree.axi[$A => A$]
// #let raw_2 = prooftree.uni[$A => B$]
First example is the tree `raw_1`.
#prooftree.tree(raw_1)f
A second tree will be:
#prooftree.tree(
    prooftree.axi[$B => AA$],
    prooftree.uni[$A => B f f f f f f f f f f f f f f f f f$]
)

A third
#prooftree.tree(
    prooftree.axi(left_label: [e], right_label: [H])[$A => A$],
    prooftree.uni(left_label: [$(equiv)$], right_label: [H])[$A => B f f f f f $],
    prooftree.uni[$A => C f$]
)
Now for a binary tree:

#prooftree.tree(
    prooftree.axi[$A => A$],
        prooftree.axi[$A => A f f g f g f f$],
        prooftree.uni[$A => B$],
    prooftree.bin[$A => B$],
)

A larger tree:

#prooftree.tree(
    prooftree.axi[$A => A $],
        prooftree.axi[$A => A $],
        prooftree.uni[$B => B$],
            prooftree.axi[$A => A $],
                    prooftree.axi[$A => A f f $],
                    prooftree.uni[$A => B$],
                prooftree.bin[$A => B$],
                    prooftree.axi[$A => A f g$],
                        prooftree.axi[$A => A f g g g g g g g g g g g g$],
                        prooftree.uni[$A => B$],
                    prooftree.bin[$A => B C$],
    prooftree.nary(4)[$A => B$],
)

Right-heavy tree:

#prooftree.tree(
    prooftree.axi[$ A => A f g g g g g g g g g g g g $],
        prooftree.axi[$A => B g g g g g g g g g g g$],
        prooftree.axi[$A => A f g g g g g g g g g g g g$],
        prooftree.bin[$ A => A f g g g g g g g g g g g g $],
    prooftree.bin[$ A => A f g g g g g g g g g g g g $],
    prooftree.axi[$A => B g g g g g g g g g g g$],
        prooftree.axi[$A => A f g g g g g g g g g g g g$],
        prooftree.bin[$ A => A f g g g g g g g g g g g g $],
    prooftree.bin[$ A => A f g g g g g g g g g g g g $],
)

We want an off-centre tree:
#prooftree.tree(
    prooftree.axi[$A vdash A$],
    prooftree.uni[$A vdash A, B$],
        prooftree.axi[$C vdash C $],
    prooftree.bin[$A, C vdash A and C, B$],
    prooftree.uni[$A, C vdash (A and C) or B$]
)


== Labels
Currently, labels are not well-placed and require much user intervention.


=== Simple
A tree with labels.
#prooftree.tree(
    prooftree.axi(left_label: [e], right_label: [H])[$A => A$],
    prooftree.uni(left_label: [$(equiv)$], right_label: [H])[$A => B f f f f f $],
    prooftree.uni[$A => C f$]
)

== Spot-check Examples

=== Wide premises
Larger premise-of-premise than conclusion.
#prooftree.tree(
    prooftree.axi[$A A A A A A A A A A A A A A A$],
    prooftree.uni[$A$],
    prooftree.uni[$B => A$]
)

Larger premise-of-left-premise than conclusion.
#prooftree.tree(
    prooftree.axi[$A A A A A A A A A A A A A A A$],
    prooftree.uni[$A$],
    prooftree.axi[$A A A A A A A A A$],
    prooftree.bin[$B => A$]
)


=== Custom Lines
#prooftree.tree(
    prooftree.axi[$A A A A A A A A A A A A A A A$],
    prooftree.uni(line_config: (stroke: (dash: "dashed")))[$A$],
    prooftree.axi[$A A A A A A A A A$],
    prooftree.bin(line_config: (stroke: 2.5pt + blue, overhang_l: 20pt))[$B => A$]
)

== From the README
First:
#prooftree.tree(
    prooftree.axi[$A => A$],
    prooftree.uni[$A => A, B$]
)

Second:
#prooftree.tree(
    prooftree.axi[$B => B$],
    prooftree.uni[$B => B, A$],
    prooftree.uni[$B => A, B$],
        prooftree.axi[$A => A$],
        prooftree.uni[$A => A, B$],
    prooftree.bin[$B => A, B$]
)

N-ary:
#prooftree.tree(
    prooftree.axi[$P_1$],
    prooftree.axi[$P_2$],
    prooftree.axi[$P_3$],
    prooftree.axi[$P_4$],
    prooftree.axi[$P_5$],
    prooftree.axi[$P_6$],
    prooftree.nary(6)[$C$],
)
