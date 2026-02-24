#import "config.typ": nuova

== Bit e Byte stuffing
<bit-e-byte-stuffing>

Sono due metodi per rappresentare l'inizio e la fine di un frame nel
data link tramite un byte speciale detto flag byte. Nel caso il payload
del pacchetto contenga lo stesso byte i due metodi usano soluzioni
diverse: il byte stuffing aggiunge uno o più byte speciali detti
#emph[di escaping ]che segnalano al destinatario di interpretare come
parte del payload il byte successivo, mentre nel bit stuffing viene
aggiunto un bit ogni volta che viene rilevata una sequenza di bit simile
a quella del flag byte. Il bit stuffing è occupa molto meno spazio ma è
più lento da eseguire del byte stuffing poiché i moderni calcolatori
sono ottimizzati per operare una word alla volta, invece che eseguire
operazioni bit per bit. Nessuno dei due metodi ha controlli di
integrità. \[Pg 199 en\]
HDLC usa il bit stuffing mentre PPP usa il byte stuffing.

== #nuova I protocolli sliding window
<sliding-window>

Si tratta di una famiglia di protocolli dove mittente e destinatario permettono di ricevere solo una specifica parte di una sequenza di pacchetti detta finestra. Ogni pacchetto al di fuori di questa finestra viene scartato. La finestra viene fatta \"avanzare\" di uno quando riceve il pacchetto con il numero di sequenza corrispondente al limite inferiore della finestra, permettendo al mittente di inviare una parte successiva del messaggio e così via. Poiché i pacchetti possono arrivare disordinati il destinatario ha un buffer delle stesse dimensioni della finestra. Alcuni esempi di protocollo sono il _go-back-n_ e le _sliding windows_. Viene utilizzato nel protocollo TCP e in vari protocolli a livello data-link. 
Viene utilizzato dal protocollo HDLC (High-level Data Link Control) e da TCP per il flow control.
== Go-back-N
<go-back-n>

La go-back-n è una tecnica di gestione degli errori usata nei protocolli
sliding windows quando è presente una banda e una latenza di
trasmissione molto alta. Quando viene rilevato un errore in un pacchetto
della sequenza il ricevente scarta in automatico tutti i pacchetti
successivi e invia in cumulative acknowledgment per tutti i pacchetti
precedenti. Il mittente dovrà quindi rinviare tutti i pacchetti
scartati, processo molto costoso nel caso il canale sia molto
disturbato. Per rimediare a questo difetto è stato creato il protocollo
selective repeat, che permette di rinviare meno pacchetti a costo di un
uso di memoria maggiore.

== Selective repeat
<selective-repeat>

Il selective repeat è una tecnica di gestione degli errori usata nei
protocolli sliding windows quando è presente un canale molto disturbato
e quindi la tecnica del go-back-n risulterebbe inefficiente. Nel caso
venga rilevato un errore in uno dei pacchetti questo è l'unico per cui
non viene mandato un ACK al mittente, che dopo un timeout ritrasmetterà
il pacchetto corrotto.  Per questioni di efficienza gli ACK sono cumulativi: ovvero il mittente invia un acknowledgment se e solo se tutti i pacchetti precedenti sono stati ricevuti. Una versione leggermente più efficiente invia al mittente dei NAK (Negative ACK) 
per ridurre il tempo prima che questo ritrasmetta il pacchetto corrotto. 
È però efficiente solo se la latenza di trasmissione è bassa.


// altre domande

// == #nuova Codice di Hamming
// <codice-di-hamming>
