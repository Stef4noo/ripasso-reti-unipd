#import "config.typ": *
#show: conf

#page(margin: (inside: 2.5cm, outside: 2.5cm))[
  #stack(
    image("img/haxxer.jpeg", width: 4cm),
    title[Ripasso Reti di \ calcolatori],
    spacing: 5mm,
    dir: ltr,
  )

  #place(bottom + left)[
    #emph[Ogni risposta deve contenere: spiegazione (cos'è e dove viene usata), pregi, difetti.]

    Con #poco sono indicati gli argomenti visti velocemente
    nel A.A. 2025-26, con #nuova le domande non presenti in esami precedenti.

    Nota bene personale: latenza di trasmissione è un termine abbastanza
    generico, RTT (Round Trip Time) o RTD (Round Trip Delay) è un termine
    più rigoroso per definire il tempo che un pacchetto percorre nell'etere
    \/ mezzo di trasmissione prima di arrivare al ricevente.
  ]
]

#pagebreak()
= Livello 1: strato fisico
#include "cap2_livello_fisico.typ"

#pagebreak()
= Livello 2: data-link
#include "cap3_datalink.typ"

#pagebreak()
= Suddivisione di un canale
#include "cap4_suddivisione_canale.typ"

#pagebreak()
= Livello 3: la rete
#include "cap5_livello_rete.typ"

#pagebreak()
= Livello 4: il trasporto
#include "cap6_trasporto.typ"

#pagebreak()
= #poco Pillole di sicurezza
#include "cap8_sicurezza.typ"



// = Domande a caso
// CSMA/CA (bitmap)
// PPP Vs HDLC
