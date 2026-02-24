== Aloha 🏝️
<aloha>

È un protocollo a contesa, ovvero dove ogni stazione compete
per un canale condiviso dove possono esserci collisioni. Ogni stazione
tenta di inviare il proprio pacchetto ad una stazione centrale, che
periodicamente fa il broadcast di tutti i pacchetti ricevuti. In questo
periodo ogni stazione ascolta e rinvia il pacchetto dopo un periodo di
attesa casuale. Non è molto efficiente in quanto la banda netta è
solamente il 18% della banda totale, ma fu il primo protocollo ad essere
infinitamente scalabile per ogni numero di stazioni. Viene utilizzato in
contesti con molti utenti non sincronizzati con un traffico dati scarso
e dove la latenza non è problematica.

Una sua evoluzione, lo slotted Aloha, suddivide in intervalli lunghi un
frame il canale per ridurre le collisioni e quindi aumentare
l'efficienza, portandola al 37%. Per la sincronizzazione l'antenna
centrale invia un segnale di clock per segnare gli intervalli. Un
difetto dei metodi Aloha è che il numero di collisioni aumenta
esponenzialmente alla frequenza di tentativi di invio di un pacchetto.
Per correggere questo difetto sono nati protocolli più moderni a contesa
limitata, dove si limita il quanti utenti e quanti tentativi di invio
possono essere fatti in un certo periodo di tempo.

== CSMA
<csma>

Il CSMA (Carrier Sense Multiple Access) è una evoluzione di Aloha in cui
si introduce il Carrier Sense: il trasmittente è quindi capace di
rilevare se il canale è già occupato e aspetta fino alla fine della
trasmissione per trasmettere. In caso di normale collisione si comporta
come Aloha puro. Con questa miglioria si ottiene una efficienza del 50%
ma non si è esenti da problemi: se le stazioni sono distanti e il tempo
di propagazione tra una stazione ed altra è alto è possibile che più
stazioni inizino a trasmettere nella frazione di tempo in cui il canale
è libero e la trasmissione dell'altra stazione non li ha ancora
raggiunti. Per evitare il primo di dei due problemi è nato il
p-Persistent CSMA, che si comporta come il CSMA ma ha una probabilità
$p$ di trasmettere un pacchetto quando il canale si libera.
Funziona molto bene nella teoria con $p$ estremamente bassi, che
però comportano una enorme latenza in una rete poco trafficata.

== CSMA non persistent
<csma-non-persistent>

È una variante del CSMA dove invece di aspettare la liberazione del
canale il trasmittente aspetta un periodo casuale prima di riprovare a
trasmettere. Rispetto al p-Persistent CSMA, che trasmette con una
probabilità appena il canale si libera, ha una efficienza del 90% e
gestisce meglio delle altre varianti del CSMA trasmissioni con diverse
quantità di traffico.

== Walking tree protocol
<walking-tree-protocol>

Si tratta di un protocollo a contesa limitata dove si minimizzano le
possibili collisioni limitando il numero di stazioni che possono
trasmettere. In caso di collisione si usa una ricerca binaria, dove ogni
stazione è rappresentata come una foglia in un albero binario, mentre
tutti gli altri nodi rappresentano i gruppi di appartenenza di una certa
foglia. In caso di collisione si limita il numero di stazioni che
possono trasmettere scendendo l'albero binario finché non ci sono
collisioni. A differenza di altri metodi come Aloha, CSMA e le loro
varianti e Basic Bitmap ha delle ottime performance indipendentemente da
quanto sia congestionata la rete.

Per questo motivo e il fatto che sia un protocollo per reti locali e non
globali (ovvero non viene usato per gestire una serie di antenne, e le
loro connessioni, ma solo quella di una singola antenna) viene
utilizzata nella telefonia mobile, dove la topologia e la congestione
della rete cambiano molto e velocemente.

== Problema della stazione nascosta
<problema-della-stazione-nascosta>

È un problema presente nella comunicazione wireless: quando due stazioni
che sono troppo distanti per essere a conoscenza dell'altro ma
abbastanza vicine da avere un ricevitore in comune possono causare
collisioni cercando di trasmettere alla stazione comune. Una delle prime
soluzioni fu il protocollo MACA (Multiple Access Collision Avoidance),
che permette a un mittente di coordinare con il ricevitore l'invio di un
pacchetto tramite due primitive: un pacchetto RTS (Request-To-Send) dove
il mittente chiede il permesso di trasmettere, mentre con il pacchetto
CTS (Clear-To-Send) il ricevitore conferma che è pronto a ricevere la
trasmissione. Non è però un protocollo perfetto: ci possono comunque
essere collisioni sulle richieste RTS, in tal caso i mittenti attendono
un periodo casuale prima di ritentare la trasmissione.
