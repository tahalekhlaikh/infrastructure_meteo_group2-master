## Contexte du projet
ICD Meteo est une application web permettant de fournir des prévisions météorologiques “sonifiées”. Elle est responsive et accessible aux personnes déficientes visuelles.
Techniquement, c'est une application écrite en Javascript, qui utilise le framework VueJS/Vuetify et la librairie Vite.
Cette application est une maquette rapidement développée dans le cadre l'enseignement "Gestion de projets agiles et en équipe" par la promotion MS-ICD 2023.
Ce projet industriel consiste à reprendre l'application météo qui avait été développée dans le cadre du module gestion agile, et de mettre en place une chaine de CI/CD, permettant d'améliorer le code en production de façon sûre et automatisée.

Ce projet est devisé en plusieurs étapes qui commence par une Analyse de l'application, en suite la création du pipeline qui es composé des étapes suivantes : 

•	Intégration continue
•	Livraison continue
•	Déploiement continue

Après le déploiement de l’application, il est nécessaire de faire un suivi de l’état de l’application, et c’est pour cette raison il existe une dernière étape qui est le monitoring. 


## Intégration Continue :

Cette étape consiste à mettre en œuvre des tests pour l'application météo afin de tester la qualité́ du code en utilisant des linters. 
Pour tester l’intégralité des fichiers de l’application, il faut utiliser plusieurs linters
La raison du choix pour mettre plusieurs linters pour chaque type de fichier au lieu mettre juste un seul réside dans la possibilité́ d'utiliser d'autres règles pour analyser le code vu que chaque linter a ses propres règles. 

Pour les fichiers html : on utilise deux linters afin d’avoir plus de règles pour tester les fichiers  
•	Le premier linter html est html-validate qui permet de Valider la conformité des fichiers HTML aux normes W3C


Pour l’installer on utilise la commande : npm install -g html-validate.
et pour l’exécuter on utilise : html-validate /index.html


•	Le deuxième linter html est html-hint

Pour l’installer on utilise la commande : npm install -g htmlhint
et pour l’exécuter on utilise : htmlhint myfile.html

il y a aussi du code JavaScript ce qui va permettre d'utiliser d'autre linters pour tester la qualité du code de ce dernier.
Pour cette partie de JavaScript, on a opté pour 3 linters :
•	Le premier linter pour le code JavaScript est JSHint qui est un outil d'analyse de code statique utilisé pour vérifier si le code source JavaScript est conforme aux règles de codage. 
Pour l’installer on utilise la commande : npm install -g jshint

et pour l’exécuter on utilise la commande : jshint suivi par le dossier dans lequel il y a les fichiers JavaScript 

•	Le deuxième linter pour le code JavaScript est standardJS qui permet aussi d'analyser et de faire des tests pour les fichiers JavaScript. 
Pour l’installer on utilise la commande : npm install standard –global

et pour l’exécuter on utilise la commande : npx standard directement dans le dossier 


•	Le troisième linter pour le code JavaScript est ESlint qui permet d’identifier les erreurs dans du code JavaScript.

Pour l’installer on utilise la commande : npm install eslint --save-dev

et pour l’exécuter on utilise la commande : npm run lint


## Partie Dockerisation:

Dans cette partie il ya  deux dockerfile en deux manière différente, pour le premier dockerfile1 qu’on peut utiliser localement on a fait toutes les configuration dans un seul dockerfile en deux stages, satge de developpement pour builder l’application et stage production en utilisation l’image nginx. Pour le tester localement :

docker build -t meteo -f Dockerfile1 . 
docker run –p 8000:80 meteo

Pour le Dockerfile2, contient juste la configuration de serveur nginx en utilisant le fichier dist qui est généré hors le dockerfile comme artefact dans le pipeline. Parce qu’il faut tester les fichiers statiques dans le pipeline qui seront générer après la compilation



## Infrastructure de l'application

Dans cette partie nous avons crées un dossier terraform pour l'automatisation de la création de l'Infrastructure et un dossier ansible pour le déploiement de l'application méteo dans l'infrastructure.

### terraform

L'infrastructure est conposée de:
+ Une machine bastion pour la configuration du cluster swarm
+ Un noeud master 
+ Trois noeuds workers

Le job terraform permet de faire le plan et l'apply.

### ansible

L'application méteo a été déployée à l'aide des playbooks suivants:
+ init-cluster.yaml: permet d'initialiser le cluster sur le noeud master
+ join-cluster.yaml: permet faire le join du cluster sur les noeuds workers
+ ha-proxy.yaml: permet de déployer le haproxy et le configurer dans le noeud master
+ service.yaml: permet de déployer le service sur les noeuds workers

Le job ansible permet de faire le run de l'ensemble des playbooks.
Le haproxy est utilisé comme load balancer dans le cluster.
Pour accéder au service, il faut configurer le proxy dans tous noeuds et visiter la page http://<ip-address-master>:80.

## Monitoring:


•	Utilisation de la machine zabbix-server installé dans le TP de zabbix.

•	Installez l'agent Zabbix sur votre hôte Docker : l'agent Zabbix est un processus léger qui s'exécute sur la même machine que votre hôte Docker et collecte des métriques à partir de votre application et de vos conteneurs. 

•	Commandes pour installer l’agent zabbix sur ubuntu 20.04 :

wget https://repo.zabbix.com/zabbix/5.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.0-1+focal_all.deb 
sudo dpkg -i zabbix-release_5.0-1+focal_all.deb
sudo apt update
sudo apt install zabbix-agent

•	Configuration de l'agent sur un hôte Ubuntu. Les fichiers de configuration se trouvent dans /etc/zabbix.

•	Réaliser la configuration de l'agent * Server : serveur autorisé à démander des métriques * ServerActive : l'adresse du serveur a qui envoyer les métriques (trapping) * Hostname : le nom de l'hôte.

•	Puis, redémarrer l'agent avec la commande sudo systemctl restart zabbix-agent.service

•	Après avoir installé et configurer l’agent zabbix, il est temps pour créer un host dans l’interface web de zabbix avec le même nom donné avant dans le fichier de configuration de zabbix.

•	Il faut choisir un groupe pour le host et l’adresse IP privé de la machine dans laquelle l’agent zabbix a été configurer.

•	Il va falloir maintenant ajouter un Template qui exploite l'agent.

•	Pour cela, nous pouvons nous baser sur le template "Linux by Zabbix agent" prédéfini. 

•	Pour surveiller le service SSH, on ajoute un autre template prédéfini qui est "Template APP SSH Service"

•	On crée un trigger pour l’item utilisé dans le template SSH, qui va déclancher une alerte lorsque le service est down, l’expression utilisée dans ce trigger est la suivante :

{Hostname:net.tcp.service[ssh].last( )}=0 
avec Hostname c’est le nom du host qui a été créé.
•	Pour surveiller le traffic réseau entrant et sortant sur l’interface réseau ens3, on crée deux nouvaux Item un pour le traffic entrant et l’autre pour le traffic sortant.
Les clès à mettre dans chaque item sont les suivants :
traffic entrant : net.if.in[ens3]
traffic sortant : net.if.out[ens3]

•	Pour surveiller l’état d’exécution des containers dans les hosts de la stack swarm, on configurer l’agent zabbix pour collecter des métriques en modifiant le fichier de configuration et en ajoutant les lignes suivantes :
UserParameter=docker.discovery[*],/usr/bin/python3 /usr/local/bin/zabbix-docker.py discover "$1”
UserParameter=docker.stats[*],/usr/bin/python3 /usr/local/bin/zabbix-docker.py stats "$1" "$2"
Ces lignes configurent l'agent Zabbix pour utiliser un script Python appelé "zabbix-docker.py" pour découvrir et collecter des métriques à partir des conteneurs Docker.

•	Dans l'interface Web Zabbix, créer un nouvel élément pour surveiller la santé de votre application.

•	Dans le formulaire de configuration de l'article, vous pouvez spécifier les éléments suivants :


Nom : un nom descriptif pour votre élément, tel que "Application Health".

Type : sélectionnez "Agent Zabbix (actif)" comme type d'élément.

Clé : spécifiez la clé qui correspond au point de terminaison de vérification de l'état de l’application. La clé utilisé est : net.tcp.service[http,IP publique de l’hote,8000]

Intervalle de mise à jour : spécifiez l'intervalle auquel Zabbix doit collecter les données de votre application. Par exemple, vous pouvez définir l'intervalle sur 30 secondes.

•	Créer un déclencheur Zabbix pour alerter en cas d'état malsain : Enfin, vous pouvez créer un déclencheur Zabbix pour vous alerter lorsque la vérification de l'état de votre application échoue. Pour cela, rendez-vous dans l'onglet "Configuration", cliquez sur "Triggers", puis cliquez sur "Create Trigger". Dans le formulaire de configuration du déclencheur, vous pouvez spécifier les éléments suivants :
•	Nom : un nom descriptif pour votre déclencheur, tel que "Application défectueuse".
•	Expression : une expression logique qui prend la valeur true lorsque la vérification de l'état de votre application échoue. L’expression utilisée pour declancher l’alerte si la valeur de l’item = 0 est la suivante :

{Hostname:net.tcp.service[http,IP publique de l’hote,8000].last( )}=0




** Gestion des logs**
Nous avons supervisé un fichier logs généere par la command docker compose log, Ce log contient des informations sur l’execution de l'application meteo qui peuvent nous aider à réagir,aux problèmes potentiels, nous avons utilisé Zabbix qui permet la surveillance centralisé et l’analyse des logs. un element de surveillance de log avec le mode actif de l’agent Zabbix et en utlisant le chemin complet du fichier log qu’on souhaite surveiller.
Nous avons créé un élément qui lit le fichier log. Pour ce faire, nous allons dans l'onglet "Configuration" de l'interface web de Zabbix, sélectionnez "Hosts", puis on sélectionne l'hôte. Cliquez sur l'onglet "Items", puis sur le bouton "Create item".
Dans le formulaire "Create item", on indique le type d'élément par "Zabbix agent (active)" et on définisse la clé "log[file,chemin vers le fichier journal]".
Puis on crée un trigger basé sur la sortie du log de l'élément. Pour ce faire, nous allon dans l'onglet "Configuration" de l'interface web de Zabbix, sélectionnez "Hosts", puis on sélectionne l'hôte que vous souhaitez surveiller. on cliquz sur l'onglet "Triggers", puis sur le bouton "Create trigger".
Dans le formulaire "Créer un trigger", on définit l'expression du trigger comme suit :
{<nom d'hôte>:log[file,<chemin vers le fichier journal>].str("Error")}
On remplace <nom d'hôte> par le nom de l'hôte qu'on surveille dans notre cas c'était "test", par le chemin d'accès au fichier log qu'on surveille. Nous avons mis une condition sur le mot cle qui “error”, on recoit donc une alerte de haut niveau dans le daoshborad de zabbix lorsque le mot "Error" apparaît dans le fichier log
Et pour génère une alerte ou une notification lorsque le trigger est activé, on crée une action en spécifiant les destinataires du courriel, le sujet et le contenu du message dans la configuration de l'action.

### Customize configuration

See [Configuration Reference](https://vitejs.dev/config/).
