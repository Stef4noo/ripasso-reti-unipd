#let conf(any) = {
  set text(
    lang: "it",
    size: 12pt,
  )

  show title: set text(font: "IBM Plex Mono", size: 26pt)

  show math.equation: set text(font: "IBM Plex Math")
  show heading.where(level: 1): set align(center)
  show heading.where(level: 1): set text(size: 18pt)
  show heading.where(level: 1): emph

  show link: set text(fill: fuchsia)
  set par(leading: 0.55em, justify: true)

  show figure.caption: set text(size: 11pt)
  set page(margin: (inside: 3.2cm, outside: 2.5cm))

  any
}

#let nuova = $ast.square$
#let poco = $dot.o$
