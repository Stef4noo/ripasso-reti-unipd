#import "config.typ": nuova, poco

== Attachi cyphertext only
<cyphertext>

//da ricontrollare
È un metodo che cerca di diminuire la quantità di tentativi bruteforce da eseguire analizzando certe caratteristiche di una lingua come la frequenza di certe sillabe o lettere. Viene usato per decifrare messaggi crittografati con metodi semplici come la sostituzione monoalfabetica o il DES.
Oggigiorno è usato assieme ad altri metodi più avanzati in quanto gli algoritmi di crittografia moderna non creano gli schemi ripetitivi alla base di questo tipo di attacco.

== Sostituzione monoalfabetica
<sostituzione-monoalfabetica>

La sostituzione monoalfabetica è una tecnica crittografica classica che
consiste nella sostituzione di ogni lettera del testo in chiaro (plaintext)
con un’altra lettera dell’alfabeto, secondo uno schema fisso determinato da
una chiave segreta. Tale tecnica mira a rendere il testo non comprensibile a
chi non conosce la chiave utilizzata per la cifratura.
Oggigiorno non viene praticamente mai utilizzata poiché facilmente decifrabile
con metodi come l'analisi di frequenza di certe lettere o sillabi.

== Cifrari a trasposizione
<cifrari-trasposizione>

Sono dei cifrari che scambiano la posizione dei caratteri secondo uno schema predeterminato dalla chiave simmetrica di cifratura, senza cambiarne il valore come la sostituzione monoalfabetica. Il messaggio così crittografato è più difficile da decifrare in quanto lascia segni meno evidenti di ripetizioni.
Sono semplici da implementare e possono essere molto veloci tramite dei semplici acceleratori hardware.
Sono considerati obsoleti grazie alla potenza dei moderni calcolatori e dalla presenza di algoritmi più complessi e sicuri. Al giorno d'oggi vengono usati solo assieme ad altre tecniche di cifratura per aumentare l'entropia del messaggio crittografato (come viene ad esempio fatto dai block cypher).

== One time pad
<one-time-pad>

È un cifrario che codifica il messaggio in chiaro eseguendo lo XOR tra il messaggio e la chiave. La parte della chiave usata sarà poi scartata per rendere impossibile qualunque tipo di crittoanalisi. È un metodo matematicamente perfetto che però richiede dei prerequisiti molto complessi da applicare in larga scala come:
- lo scambio sicuro di chiavi enormi, lunghe almeno quanto il messaggio,
- una chiave veramente casuale enorme, cosa poco scontata e difficile da ottenere.
Viene usato solamente in ambiti critici come lo scambio di messaggi tra governi e varie agenzie di intelligence, in quanto altri metodi di cifratura sono comunque ragionevolmente sicuri e hanno una creazione e scambio delle chiavi molto più semplice, come l'algoritmo AES.

== #nuova Block cypher
<block-cypher>

Sono tecniche che trasformano un blocco di simboli/bit alla volta invece che un carattere alla volta usando ogni volta la stessa chiave. Per rendere l'analisi delle ricorrenze più difficili si usano più block cypher sullo stesso messaggio per aumentarne l'entropia.
Le implementazioni più semplici che usano poche permutazioni sono considerate insicure, come per esempio l'obsoleto ECB.
Alcuni esempi di block cypher sono gli algoritmi RSA, AES e DES.
Vengono usati nella quasi totalità delle comunicazioni cifrate poiché è facile generare casualmente le chiavi richieste da questi algoritmi, a differenza dei one time pad.

== DES e triplo DES
<des>

Il DES è un block cypher che permuta blocchi da 128 bit in 16 iterazioni composte da scambi e sostituzioni definite da una chiave anch'essa da 128 bit.
Fu creato dalla IBM e poi standardizzato dalla NSA con chiavi ridotte a 56 bit e blocchi da 64 bit.
Fu adottato nel 1977 e fu sostituito prima dal triplo-DES e infine dal più
moderno e sicuro AES nel 2002
#footnote[#link("https://en.wikipedia.org/wiki/Data_Encryption_Standard#Chronology")].
La transizione fu necessaria grazie al continuo miglioramento del hardware consumer, che permise di effettuare attacchi bruteforce efficaci su connessioni DES già nel 1999.
Il triple-DES è un sistema che usa tre chiavi del DES, di cui almeno due univoche, per codificare e decodificare i dati. È retrocompatibile con il DES usando tre volte la stessa chiave. Anch'esso fu sostituito poiché facilmente violabile grazie all'aumento della potenza di calcolo dell'elettronica consumer.

== ECB
<ecb>

L'Electronic CodeBook è il block cypher più semplice in assoluto. Ogni blocco è criptato separatamente tramite una chiave simmetrica, come per esempio la frase di un libro, da cui deriva il nome dell'algoritmo. Poiché due blocchi identici sono crittografati allo stesso modo ogni blocco può essere crittografato in parallelo e quindi molto velocemente. Altrettanto velocemente si può però decrittare il messaggio tramite una analisi delle frequenze, poiché non genera casualità nel messaggio finale, motivo per cui oggi è un algoritmo superato.

#figure(
  image(
    "img/ecb wikipedia.png",
    width: 80%,
  ),
  caption: [#link("https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#ECB")[wikipedia.org]],
)
\

== Counter mode cypher 
<ccmp>

Il counter mode cypher è un block cypher che aumenta l'entropia di un messaggio crittografato aggiungendo alla funzione di codifica un contatore, in modo che due blocchi identici non siano codificati alla stessa maniera. Viene usata nel protocollo CCMP, che a sua volta viene usata in WPA2 per la segretezza delle comunicazioni. Si basa su AES con un cifrario counter mode usato su blocchi e chiave da 128 bit.

== Stream cypher
<stream-cypher>

Sono una famiglia di algoritmi block cypher che operano similmente al one time pad, in cui un blocco del messaggio viene crittografato eseguendo lo XOR con un blocco di eguali dimensione del _keystream_, che viene poi scartato. Il _keystream_ viene generato pseudo-casualmente da una chiave simmetrica. È un metodo estremamente veloce, motivo per cui questi algoritmi vengono usati per applicazioni che richiedono la minore latenza possibile, come lo streaming audio e video in tempo reale e le chiamate VoIP. Una sua versione, il RC4, viene usato dal WEP per la crittografia dei dati. 

== Hash, HMAC
<hmac>

Una funzione di hash è una funzione che, dato un qualunque input, genera una stringa  di lunghezza fissa. Non essendo biunivoca è molto difficile risalire ai dati originali dal hash.
HMAC (Hash-based Message Authentication Code) è un metodo di autenticazione e controllo dell'integrità basato sull'uso degli hash: ogni pacchetto contiene un hash della concatenazione di messaggio, chiave segreta ed eventuale padding
#footnote[#link("https://datatracker.ietf.org/doc/html/rfc2104")] <rfc2104>.
Viene usato nei protocolli TLS, HTTPS e IPsec con una funzione di hash specificata dal protocollo rappresentata come HMAC-[metodo hash], per esempio HMAC-SHA256.
La robustezza di HMAC dipende dal metodo di hash utilizzato. Si può aumentare la sicurezza del protocollo inviando una parte troncata del hash @rfc2104.

== Attacchi DNS
<attacchi-dns>

//risposta un po' meh

Il DNS (Domain Name System) si occupa della traduzione da nome di dominio a indirizzo IP.
Essendo essenziale per la navigazione in Internet sono stati sviluppati diversi metodi per renderlo inacessibile o sostituirsi ad esso, come il _DNS spoofing_ che permette ad un utente malevolo di rispondere al posto di un server autorevole ad un utente. Creare dei finti pacchetti UDP di risposta non è difficile: DNS di default opera in chiaro. Per sostituirsi ad un server autorevole si può inibire la capacità del server di gestire richieste tramite un attacco DoS o DDoS (che satura la capacità di risoluzione dei domini) o anche con l'ARP spoofing se l'utente malevolo è connesso alla rete.

== IPsec
<ipsec>

IPsec è uno standard di rete che cerca di rendere le connessioni IP sicure tramite l'implementazione di crittografia, autenticazione e controllo dell'integrità.
La complessa implementazione di queste funzionalità causa un overhead maggiore nell'elaborazione dei pacchetti rispetto a IP, ma in cambio offre:
- la possibilità di creare e connettersi a reti virtuali tramite la _tunnel mode_ (le VPN);
- verifica l'origine del pacchetto (tramite HMAC, che si occupa anche dell'integrità del pacchetto);
- la negoziazione dello scambio delle chiavi crittografiche;
- una protezione base dai _replay attack_.

== #nuova WEP
<wep>

Il Wired Equivalent Privacy fu il primo protocollo di sicurezza pensato per le reti wireless specificate nel IEEE 802.11. Per la crittografia dei dati usava RC4, uno stream cypher che esegue lo XOR tra un blocco di dati e parte del _key stream_ generato dalla chiave (ovvero la password). Dei difetti di progettazione in WEP resero lo standard particolarmente debole: parti dello _key stream_ erano spesso uguali, rendendo l'analisi delle frequenze un metodo affidabile per ottenere la chiave privata e quindi poter intercettare tutto il traffico di rete della rete #footnote[Pagina 823 Computer Networks 5th edition].
Esistono alcuni strumenti gratuiti che permettono in maniera affidabile di scoprire la chiave di una rete WEP in meno di un minuto già dal 2007
#footnote[#link("https://eprint.iacr.org/2007/120.pdf")], 
solo 8 anni dopo la rettificazione dello standard 
#footnote[#link("https://it.wikipedia.org/wiki/Wired_Equivalent_Privacy")].
Fu sostituito temporaneamente da WPA e infine dal ben più robusto e sicuro WPA2, che è oggigiorno il protocollo più usato in reti domestiche e aziendali. Usa uno CCMP, uno stream cypher in counter mode, rendendo quindi più difficile l'analisi della frequenza.
