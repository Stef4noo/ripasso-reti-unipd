#import "config.typ": nuova, poco

== Codifica Manchester 
<codifica-manchester>

Si tratta di una codifica dei bit dove un simbolo è rappresentato da un
cambio di voltaggio da alto a basso o da basso a alto (che rappresentano
rispettivamente 0 e 1). Un segnale si codifica eseguendo uno XOR tra il
flusso dati e un clock con frequenza doppia. Un suo pregio è che il
segnale può essere decodificato senza previa sincronizzazione. Ha un
data rate però relativamente basso: la metà del baud-rate massimo e non
si può spingere a frequenze molto alte senza incorrere in problemi non
triviali. #footnote[
#link("https://en.wikipedia.org/wiki/Manchester_code")
] Viene usato nel DSL e nello standard Ethernet poiché molto economico visto che non necessita di precisi e costosi circuiti di clock.

== #poco Modulazione di fase 
<modulazione-di-fase>

- #link("https://en.wikipedia.org/wiki/Phase_modulation")
- #link("https://it.wikiversity.org/wiki/Modulazioni_analogiche#Modulazione_di_fase")
- \+ en pg 130

È una modulazione che codifica un simbolo come variazioni nella fase di
una o più frequenze. Permette un maggiore bit rate a parità di baud-rate ed è la base per
modulazioni più complesse e performanti come il QAM, che usa
contemporaneamente la modulazione di fase e di ampiezza per aumentare il
numero di baud trasmissibili in una certa banda.

== CDMA 
<cdma>

Il Code Division Multiple Access è un metodo di multiplexing che
permette a più dispositivi di trasmettere sulla stessa frequenza senza
causare collisioni. Ad ogni dispositivo viene assegnata una #emph[chip
sequence] formata da una serie di 0 e 1 che rappresenta il simbolo 1
associato a quel specifico mittente. Grazie al metodo di Walsh ogni
sequenza, rappresentabile come vettore, è ortogonale ad ogni altra
sequenza.

Grazie a questa proprietà eseguendo la somma normalizzata tra il segnale
ricevuto, ovvero la somma delle chip sequence di ogni dispositivo che ha
trasmesso, e la chip sequence di un particolare mittente è possibile
ottenere la word originale inviata dal mittente.

Questo metodo ha una efficienza spettrale molto alta, e per questo viene
utilizzato negli standard Wi-Fi, nel 2G e in certe varianti del 3G, ma
richiede che ogni dispositivo invii il proprio messaggio alla stessa
potenza per poter effettuare il demultiplexing. Questo prerequisito
richiede che ogni antenna trasmetta ad una potenza nota al mittente, in
modo che possa regolare la potenza di trasmissione conseguentemente.

== #poco QPSK
<qpsk>

La Quadrature Phase Shift Keying è una tecnica di trasmissione dati
basata sulla modulazione di fase di due frequenza in 4 punti
equidistanti a coppie. Rispetto alla modulazione di fase di una singola
frequenza ha un baudrate doppio. Per renderlo più resiliente alla
distorsione e al rumore l'encoding viene effettuato con il codice di
Gray#footnote[
#link("https://en.wikipedia.org/wiki/Phase-shift_keying")
] (ovvero ogni simbolo consecutivo differisce di un solo bit da quello
precedente#footnote[
#link("https://en.wikipedia.org/wiki/Gray_code")
]). A differenza del QAM usa solo la modulazione di fase e non anche
quella di ampiezza.

== QAM
<qam>

Info utili su
#link("https://www.quora.com/What-is-meant-by-QAM/")[quora] e
#link("https://techdifferences.com/difference-between-qam-and-qpsk.html")[techdifferences].

La Quadrature Amplitude Modulation è una tecnica di trasmissione che usa
contemporaneamente la modulazione di fase e di frequenza su due
frequenze dette portanti, solitamente rappresentate dalle lettere Q e I.
Aumentando il numero di modulazioni possibili posso aumentare il
data-rate mantenendo costante il baudrate. L'alfabeto dei simboli può
essere rappresentato in un grafo a costellazione, ovvero un grafo
cartesiano dove i due assi rappresentano le due onde Q e I e la loro
ampiezza. Ogni punto sul grafo rappresenta l\'intersezione tra due
ampiezze di Q e I, ovvero un possibile simbolo.

Per la sua alta efficienza spettrale viene usato nella comunicazione
satellitare e in vari standard Wi-Fi definiti nel IEEE 802.11.

4-QAM e QPSK sono due metodi leggermente diversi che ottengono lo stesso
risultato, usano la stessa decodifica ma una codifica leggermente
diversa#footnote[
#link("https://it.mathworks.com/matlabcentral/answers/291348-difference-between-qpsk-and-4-qam")[mathworks.com]
] (i simboli sono spaziati diversamente sul grafo della costellazione).

== I satelliti 
<satelliti>

Un satellite per telecomunicazioni è un satellite artificiale orbitante
attorno alla terra usato per le comunicazioni terrestri. In base alla
loro altitudine si suddividono in geostazionari, MEO e LEO.

I satelliti geostazionari orbitano a 35800m dalla terra, distanza che
gli permette di avere la stessa velocità della terra ed essere quindi
essere stazionari. Per minimizzare le collisioni e le interferenze radio
si è limitato il numero di satelliti GEO a 180. Per la loro altitudine
sono i satelliti con la maggiore latenza di trasmissione, attorno
ai 270ms, e quelli con la maggiore copertura terrestre: con 3 satelliti è
possibile coprire l'intero pianeta Terra. Sono utilizzati per il
broadcasting televisivo (per esempio Sky Television).

A differenza dei satelliti MEO e LEO la qualità del segnale degrada
molto all'avvicinarsi dei poli terrestri. Sono i satelliti più longevi
ma allo stesso tempo i più costosi da lanciare per il loro peso e la
necessità di attraversare entrambe le fasce di Van Hallen. Per la loro
distanza la comunicazione con essi richiede ricevitori molto voluminosi
e potenti, poco adatti alla mobilità.

I satelliti MEO sono invece posizionati tra le due fasce di Van Hallen e
sono principalmente usati per la navigazione terrestre, come il GPS
americano o il sistema Galileo europeo. Poiché non sono stazionari è
necessario che il ricevente segua il transponder del satellite in cielo.
Richiedono dei transponder più piccoli ed efficienti grazie alla loro
altitudine minore, inoltre il lancio di un satellite MEO è più
accessibile data la minore distanza e la necessità di attraversare solo
una delle due fasce di Van Hallen. Questa orbita è la più popolata e
quindi la più pericolosa per la presenza di altri satelliti e di detriti
spaziali.

I satelliti LEO (Low-Earth Orbit) sono i satelliti più vicini alla
terra, con una latenza massima di soli 7ms. Sono inoltre i satelliti che
offrono maggiore banda tra i tre tipi. Questa vicinanza comporta un
minimo di 50 satelliti per avere una copertura globale, contro i 3
minimi di un sistema geostazionario o i 30 satelliti richiesti da una costellazione MEO.

Richiedono le antenne più piccole ed efficienti tra i tre tipi, motivo
per cui certi smartphone odierni supportano la comunicazione con
costellazioni LEO. Sono inoltre i più economici da lanciare ma anche i meno duraturi dei tre.
Alcune reti LEO commerciali sono Iridium e Starlink, che effettuano lo
switching tra satelliti e Globalstar, che invece usa i satelliti in
modalità bent-pipe ed effettua lo switching a terra.

Rispetto alla fibra la rete satellitare non è usata da molti privati, ma
è estremamente efficiente per ogni tipo di broadcasting (basti pensare
che un singolo satellite esegue il broadcasting di Sky per gran parte
dell'Europa), è immune ad ogni tipo di catastrofe naturale o artificiale
(e quindi molto gettonato nelle emergenze o nelle guerre) e ha prezzi
molto più accessibili della fibra in aree poco densamente popolate.

ITU = International Telecommunication Union, gestisce gli “slot”
orbitali#footnote[
#link("https://www.itu.int/en/ITU-R/space/workshopBangkok2010/03a-Orbit_Spectrum%20Allocation%20Procedures_MG.pdf")[www.itu.int]
]

== ADSL
<adsl>

La Asymmetric Digital Subscriber Line è uno standard per la trasmissione
dati digitale e analogica, nata come evoluzione necessaria del DSL per
portare velocità maggiore ai privati, sempre più propensi a navigare in
Internet. È retrocompatibile con lo standard DSL. Utilizza frequenze
fino ai 2.2 MHz suddivise in canali da 4kHz ciascuno tramite una
variante del FDM, il Discrete MultiTone. Ogni canale è trattato come una
connessione indipendente, che può essere rallentata o velocizzata in
base alla qualità del segnale. Il maggiore limite di questo standard è
il suo medium, ovvero il cavo UTP3 che percorre l'ultimo miglio: la sua
lunghezza è l'unico vero fattore che influisce sulla banda
raggiungibile. 
È tecnicamente stato superato dal VDSL che utilizza
frequenze fino ai 12 MHz, utilizzabili però soltanto se lo stesso cavo
in che percorre l'ultimo miglio non è troppo lungo o degradato per il tempo,
altrimenti il proprio datarate degrada fino a raggiungere le performance della ADSL.
Ci furono più evoluzioni di ADSL, la più performante è ADSL2+ Annex M che offre fino a 27 Mbps in download e 3.3 Mbs in upload.


== Modulazione Delta / compressione delta
<modulazione-delta-compressione-delta>

Si tratta di un metodo di compressione lossy per rappresentare dei dati
analogici digitalmente. Fu usata nel 2G sia per il GSM europeo che il
D-AMPS americano per poter gestire più chiamate su un singolo canale 1G
tramite TDM (Time Division Multiplexing). Ogni sample della voce viene
rappresentato come differenza approssimata dal sample
precedente.#footnote[
#link("https://en.wikipedia.org/wiki/Delta_modulation")
] Permette quindi una maggiore efficienza spettrale a costo di una
qualità audio percettibilmente inferiore.

N.B. da non confondersi con il delta encoding, che è un'altra cosa
ancora (principio simile ai backup differenziali).

== #poco Handoff
<handoff-mobile>

Nella telefonia ci sono due tipi di handoff:

- hard handoff: che veniva usato nel 1G, dove ogni antenna interrompeva
  la connessione con ogni dispositivi che riceveva al di sotto di una
  certa potenza;
- MAHO (Mobile Assisted HandOff): ogni telefono misura la potenza del
  segnale dell'antenna a cui è collegato durante le pause attive del TDM
  e decide automaticamente quando e come passare ad un'altra cella.
  Viene usato dal 2G in poi.
