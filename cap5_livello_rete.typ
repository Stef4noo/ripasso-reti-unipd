#import "config.typ": poco, nuova

== Flooding
<flooding>

È un protocollo di routing che si basa sul semplicemente inviare ogni
pacchetto ricevuto in broadcasting. È molto semplice ma crea molto
traffico inutile se gran parte del traffico non è broadcast. In compenso
è un protocollo molto veloce: poiché prova tutte le strade possibili per
una destinazione di sicuro prenderà anche quella più veloce. È inoltre
il metodo più robusto contro qualunque tipo di cambiamento di rete,
motivo per il quale trova largo uso in applicazioni militari e
parzialmente nel Link State Routing, il protocollo usato oggigiorno per
la gestione del routing.

== Distance Vector Routing
<distance-vector-routing>

È un protocollo di routing pensato come sostituto del flooding. Ogni
router ha una routing table che contiene i costi necessari per arrivare
ad ogni stazione che conosce. Per creare questa tabella ogni router
chiede ai propri vicini di inviare la propria. In base alle tabelle
ricevute e il tempo voluto a riceverle il router crea la propria
tabella, che viene periodicamente ricalcolata per gestire eventuali
cambiamenti nella rete. Questi aggiornamenti però non sono molto
efficaci nel caso il costo di un router aumenti di colpo: poiché nelle
tabelle ricevute non è possibile sapere se nel costo è incluso un hop in
se stesso il costo di un router congestionato salirà molto lentamente ad
ogni ricalcolo, non rappresentando fedelmente lo stato della rete.
Questo problema è detto count to infinity.

== Link State Routing
<link-state-routing>

È il successore del Distance Vector Routing ed è il protocollo usato
oggigiorno per il routing. Ogni router esegue i seguenti passaggi:

- rileva i router vicini tramite pacchetti HELLO e la loro distanza
  tramite la latenza alla risposta di pacchetti ECHO;
- sulla base di queste informazioni crea un pacchetto speciale contenente la lista di router a cui il mittente è collegato detto LSP (Link State Packet) di cui esegue il flooding;
- ogni router grazie a queste informazioni può aggiornare la propria
  routing table, il proprio LSP e la propria mappa della rete.
  Quest'ultima parte non era possibile con il DVR, che scambiava solo
  informazioni locali riguardo ai costi per raggiungere un router.

Ogni router quindi riceve informazioni globali e trasmette informazioni
locali sullo stato della rete, rendendo il LSR più robusto del DVR in
caso di cambiamenti negativi nella rete. Poiché questo flooding è
periodico viene usata più banda rispetto al DVR, ma non è presente il
problema del count to infinity. Poiché ogni router ha una mappa più
completa della rete, si possono utilizzare algoritmi migliori per il
calcolo dei percorsi, che richiedono però un hardware più potente.

== Quality of Service
<quality-of-service>

Sono una serie di parametri che definiscono la qualità del servizio
internet offerto. I 4 parametri principali sono (1) affidabilità, (2)
banda, (3) latenza e (4) jitter, ovvero la deviazione standard della
latenza in un periodo breve di tempo. Diversi servizi hanno soglie di
accettabile diverse per questi 4 parametri: per il gaming jitter e
latenza sono fondamentali, mentre il trasferimento di file priorizza
banda e affidabilità. Il fattore non fisico che impatta di più questi
parametri è la congestione della rete, motivo per il quale esistono
diversi algoritmi per regolare il traffico di dati, come il choke packet
o metodi più avanzati come i leaky buckets o i token buckets.

== Choke packet
<choke-packet>

È il metodo più semplice per gestire la congestione: quando un
destinatario sta per essere saturato invia un pacchetto speciale al
mittente, il choke packet, che alla sua ricezione dimezza la banda. Per
evitare che una serie di choke packets rallentino troppo un mittente
questo alla prima ricezione avvia un timer, detto di fading, per il
quale ignora i choke packets fino al suo esaurimento. Poiché questo
metodo è lento nel caso il mittente sia un nodo molto distante è stata
creata una sua variante, detta hop-by-hop choke, dove ogni nodo per il
quale passa il pacchetto dimezza la sua banda.

== Leaky bucket
<leaky-bucket>

Il traffico di rete viene normalizzato tramite un buffer (il
#emph[bucket]) che limita il numero di pacchetti che possono passare per
un host. Nel caso questo limite venga superato il buffer ha una riserva
limitata e quando viene riempita i nuovi pacchetti vengono scartati.
Questo metodo permette di ridurre il rischio di congestione causato dai
burst, ovvero picchi improvvisi di traffico. Viene implementato lato
mittente, permettendo quindi di non congestionare parti intermedie della
rete, costringendole a scartare pacchetti. I leaky buckets normalizzano
efficientemente ed efficacemente il traffico dati, risultano però
inadatti a gestire traffico variabile con burst di dimensioni superiori
al limite di banda, causando un rallentamento per lo scarto di
pacchetti.

La scelta della capacità del secchio e del tasso di uscita richiede una
buona comprensione delle caratteristiche della rete e delle
applicazioni, complicando la configurazione ottimale.

== Token bucket
<token-bucket>

È un protocollo per la gestione della congestione nato come evoluzione
del leaky buckets. L'interfaccia di rete del mittente genera
regolarmente una serie di token, che permettono l'attraversamento di un
pacchetto se consumanti. Se dopo un intervallo dei token sono avanzati,
vengono accumulati per la successiva serie di pacchetti fino ad un certo
limite massimo. A differenza del leaky bucket gestisce meglio i burst
nel breve periodo, che vengono smistati più rapidamente grazie ai token
accumulati durante il minor traffico precedente, senza però cambiare il
traffico medio nel lungo periodo. Una configurazione ottimale è però più
difficile da gestire rispetto ad un leaky bucket e i burst molto lunghi
causano comunque un rallentamento della trasmissione, visto che i
pacchetti devono aspettare la generazione di nuovi token e possono
venire scartati nel mentre, causando rallentamenti come i leaky buckets.
Poiché l'assegnazione dei token è arbitraria è possibile eseguire del QoS implementando specifici metodi di assegnazione.

== CIDR
<cidr>

Il CIDR (Classless InterDomain Routing) fu introdotto per usare in
maniera più efficiente il numero limitato di range di IPv4 creato con il
classful routing, rendendo possibile la creazione di reti con subnet
mask di dimensioni arbitrare, non solo /8, /12 o /16 come
precedentemente dettato dalle classi A/B/C. Nacque per necessità:
nonostante il classful routing abbia messo a disposizione il numero
giusti di classi per ogni tipo, gran parte dei clienti alla fine
comprarono un indirizzo di classe B (un blocco di circa 65mila indirizzi
IP), anche se successivi studi mostrarono che gran per gran parte di essi
sarebbe stato più che sufficiente un indirizzo di classe C (un blocco
di 255 indirizzi IP). Questo protocollo aumentò la dimensione delle
tabelle di routing, in quanto ogni indirizzo non era più separabile in
classi statiche. Per comprimere la dimensione di queste tabelle furono
introdotte le #emph[aggregate entries]: due record nella tabella se
hanno lo stesso suffisso possono essere compresse in una se entrambi
sono instradati sulla stessa linea. Il match non sarà più fatto
sull'intero indirizzo IP, ma il suo suffisso. Poiché un indirizzo IP può
comparire in più suffissi si cerca il suffisso uguale di lunghezza
maggiore per instradare il pacchetto. È un sistema più lento e
complicato del classful routing, ma fu necessario per adattare un
protocollo pensato per interconnettere università o basi militari ad una
rete globale. Viene usato in pressoché ogni rete Internet moderna.

== NAT
<nat>

Il NAT (Network Address Translation) permette di effettuare il
multiplexing di più indirizzi IP privati con un solo indirizzo pubblico.
Internamente il router sostituisce l'indirizzo e la porta sorgente con i
propri quando invia un pacchetto verso l'esterno e sostituisce porta e
indirizzo IP del destinatario quando deve instradare un pacchetto
dall'esterno verso la rete privata. La rete interna usa degli indirizzi
riservati per questo scopo (per esempio 192.168.0.0/16 nelle reti
domestiche). Nacque per necessità: con un numero sempre più stretto di
indirizzi IPv4 disponibili fu necessario per permettere a un numero
sempre maggiore di utenti di collegarsi a
Internet#footnote[
  Non proprio accurato: la causa furono le migliaia di persone che
  comprarono indirizzi di classe B quando gli bastavano quelli di classe
  C, ma non so come scrivere in maniera elegante che è colpa della
  stupidità delle persone.
].

Il NAT ha il difetto di rendere ogni connessione connection-oriented,
anche se il protocollo IP è nato come protocollo connectionless, facendo
perdere ad Internet parte della sua resilienza. È anche un single point
of failure: gestendo l'associazione dei socket internamente, in caso di
disservizio del NAT la rete interna ed esterna non hanno più modo di
comunicare tra di loro.

Viene usato da ogni ISP, soprattutto per le connessioni di privati che
non necessitano di un indirizzo IP statico. Come effetto collaterale
nasconde gli indirizzi interni da possibili attaccanti esterni,
oscurando l'organizzazione di una rete interna.

== ARP
<arp>

L'ARP (Address Resolution Protocol) è un protocollo parte del IEEE 802.3
che si occupa della traduzione di indirizzi IP in indirizzi MAC. Quando
una macchina connessa alla rete non conosce l'indirizzo MAC del
destinatario invia un pacchetto speciale in broadcast a cui risponde
solamente la macchina con l'indirizzo MAC specificato. Per rendere il
protocollo più efficiente in ogni broadcast il mittente invia in
piggyback la propria associazione MAC-IP, e ogni macchina ha una cache
su cui memorizza le associazioni di cui è a conoscenza. Alla prima
connessione di rete di una macchina questa invia in broadcast una ARP
request per se stesso, in modo da far conoscere a tutti la propria
associazione MAC-IP e per controllare la presenza di eventuali
collisioni di IP, che si scoprono nel caso un host risponda. Viene usato
in quasi ogni macchina connessa ad
Internet#footnote[
  Computer Networks 5th edition, pag 468.
], in quanto è un protocollo essenziale del secondo livello TCP/IP. Non
avendo nessun tipo di autenticazione (come gran parte dei protocolli in
TCP/IP) un utente malevolo può impersonarsi come un'altra macchina con
un attacco detto ARP spoofing#footnote[
  #link("https://en.wikipedia.org/wiki/ARP_spoofing")
].

== ICMP\[v4\]
<icmpv4>

ICMP (Internet Control Message Protocol) è un protocollo di rete di
livello 3 progettato per comunicare o richiedere informazioni di stato
ad altri dispositivi IP, ad esempio può segnalare ad un mittente che il
suo pacchetto è stato scartato dopo che il suo TTL è arrivato a zero
tramite il messaggio #emph[Time Exceeded], oppure controllare se un
dispositivo è disponibile tramite un #emph[Echo Request] a cui il
destinatario deve rispondere con un #emph[Echo Reply ]\(ovvero il
#emph[ping]). Viene anche usato per il troubleshooting di una rete
poiché è alla base di strumenti come #emph[ping] e #emph[traceroute]. La
sua utilità è però limitata poiché è un protocollo #emph[best effort],
quindi inaffidabile, ed è un ottimo vettore di attacco con tecniche come
il ICMP flooding e il smurf attack
#footnote[
  #link("https://solidwp.com/blog/icmp-attacks-everything-you-need-to-know/#h-smurf-attack")
].
Per questo certi dispositivi di rete scartano in automatico certi
pacchetti ICMP, in particolare #emph[Echo Request] ed #emph[Echo Reply.]

== IPv4
<ipv4>

IPv4 (Internet Protocol version 4) è il principale protocollo del
livello 3 di Internet. Si occupa della segmentazione dei dati in
pacchetti e del loro routing attraverso reti diverse. Per essere il più
performante possibile non è né affidabile né connection-oriented, non
offre error o flow control e ha un controllo di parità estremamente
semplice e poco robusto: offre solo un checksum in modulo 2.

Ogni dispositivo e ogni rete sono identificato da 4 cifre da un byte
ciascuno, ovvero l'indirizzo IP, e da una subnet mask che permette di
calcolare l'inizio e la fine di una rete e il suo indirizzo di
broadcast. Un pacchetto IP è formato da un header con 20 byte fissi e
una sezione variabile e un payload di dimensione variabile, definita in
uno dei fissi del header. Ogni header contiene l'indirizzo IP del
mittente e del destinatario, un checksum e vari flag e campi per gestire
dati frammentati in più pacchetti.

Inizialmente gli indirizzi IP erano organizzati in 3 classi con tre
diverse subnet per rendere più veloce il routing di un pacchetto, ma a
seguito dell'esaurimento degli indirizzi IPv4 fu necessario introdurre
il NAT e il CIDR. Queste soluzioni hanno i loro difetti: il NAT per
esempio è un single point of failure: nel caso il router abbia dei
problemi ogni connessione che passava per il NAT andrà persa e il CIDR
richiede tabelle di routing più grandi del classful routing, nonostante
le aggregate entries diminuiscano gli “effetti collaterali” del CIDR.
Per queste e altre ragioni IPv4 è stato parzialmente sostituito da IPv6,
che risolve il problema di IPv4 usando indirizzi di 128 bit.

// ipv6 delega il checksum a TCP o UDP
// indirizzo da 32bit, header variabile, no autenticazione
// organizzato in classi ma poi nat e cidr

== #poco IPv6
<ipv6>

// Risposta fatta ad cazzum prendendo interamente spunto dal libro, visto
// che è stato praticamente solo citato a lezione e molto probabilmente non sarà
// quindi in esame.

Nato nel 1998, IPv6 fu creato con il preciso scopo di sostuire IPv4 i cui 
indirizzi IP iniziavano già a scarseggiare, nonostante l'uso di NAT e CIDR.
Fu scelto tramite un bando con diversi prerequisiti, tra cui:
- risolvere a lungo termine il problema dell'esaurimento di indirizzi IPv4, anche usando una allocazione inefficiente (come è successo con IPv4);
- essere il più performante possibile;
- gestire meglio di IPv4 il QoS;
- gestire privacy e sicurezza meglio di IPv4;
- deve coesistere facilmente con IPv4.

A vincere il bando fu il protocollo SIPP (Simple IP Plus), poi rinominato IPv6. 
Per risolvere il problema dell'esaurimento degli indirizzi IP il protocollo utilizza indirizzi da 128 bit invece che 32, come IPv4. Per aumentare la velocità di elaborazione di un pacchetto
- sono stati ridotti il numero di campi nel header da 13 a 6
- l'header è di dimensione statica, eventualmente espandibile usando dei puntatori a dei header aggiuntivi opzionali;
- fu tolto il checksum del header, in quanto considerato inutilmente ridondante, visto che se ne occupano già altri livelli ed è particolarmente dispendioso da calcolare;
- per ridurre il numero di campi la frammentazione è stata tolta e la negoziazione della dimensione dei pacchetti è stata affidata agli host. Un pacchetto troppo grande viene scartato dal router che segnalerà al mittente la cosa tramite ICMPv6.

Il suo adottamento fu molto lento per permettere a ISP e aziende una transizione indolore. Questa scelta fu però la debolezza di IPv6, che ancora oggi non ha sostituito IPv4, nonostante siano stati esauriti tutti gli indirizzi IPv4 dal 2020
#footnote[#link("https://www.apnic.net/manage-ip/ipv4-exhaustion/")].
