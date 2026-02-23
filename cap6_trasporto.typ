#import "config.typ": nuova, poco

== TCP

Il TCP (Transport Control Protocol) è il principale protocollo usato in Internet 
per gestire delle connessioni affidabili tra due host. Come UDP usa l'astrazione 
delle porte per permettere il multiplexing su un singolo indirizzo IP. 
Ogni connessione è gestita tramite le _sliding windows_, che vengono avanzate tramite il campo ACK nel header, che conferma la ricezione del i-esimo byte, anche in piggyback.
In caso di fallimento di ricezione TCP usa il _go-back-n_ di default, ma è possibile abilitare il _selective repeat_ e i NAK. La frammentazione viene gestita tramite un numero di sequenza di 32b (come l'ACK) nel header. 

A differenza di UDP il protocollo TCP è solamente single-cast e ogni connessione viene aperta e chiusa "dolcemente" con una serie di passaggi e cambiamenti di flag presenti nel header, passaggi che rendono il protocollo più  lento di UDP ma affidabile.

== Handshaking TCP
#let a = text(green)[*`A`*]
#let b = text(green)[*`B`*]

L'iniziazione di una connessione TCP avviene in tre fasi sequenziali:
+ l'host #a invia a #b un pacchetto TCP con il flag `SYN` attivo e un valore casuale $x$ sul numero di sequenza;
+ #b risponde inviando ad #a un pacchetto con il flag `SYN` attivo, un `ACK` con valore $x+1$ e ponendo un numero di sequenza casuale $y$ maggiore di $x$;
+ infine #a risponde inviando un `ACK` con valore $x+1$ e numero di sequenza $y+1$.


== #poco UDP

Il UDP (User Datagram Protocol) è un protocollo di livello 4 pensato per 
essere il più performante possibile. Per questo motivo non è affidabile ma 
solamente best effort. Un header UDP è composto solamente da 4 campi:
+ porta del mittente
+ porta del destinatario
+ checksum opzionale
+ lunghezza totale del datagramma
Per queste sue caratteristiche viene utilizzato da applicazioni che necessitano 
della minore latenza di trasmissione possibile, come la risoluzione DNS e lo 
streaming audio e video. A differenza del più lento e _connection-oriented_ 
protocollo TCP permette il multicast. 
