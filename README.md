# The Dark Side

Ce mini projet a pour but de faciliter l'utilisation de Linux sur les pc de l'iut.

Le principe est très simple, il suffit de lancer un tout petit script qui va **totalement** métamorphoser l'apparence et le comportement du bureau, tout en ajoutant de vrais outils pour travailler comme des professionnels.

## Sommaire

- [Installation](#installation)
- [Les changements de l'environnement de bureau](#les-changements-de-lenvironnement-de-bureau)
- [ATOM !!!!](#atom-)
- [Beh moi je veux mon propre **The Dark Side** !](#oui-loc-moi-jaime-pas-trop-a-tu-vois-a-serait-mieux-comme-a-gnagnagna)

## Installation

### En une seule commande

```
curl -sL -o ~/net_home/the_dark_side.bash "https://raw.githubusercontent.com/L0L022/config_iut/master/the_dark_side.bash" && chmod u+x ~/net_home/the_dark_side.bash && bash ~/net_home/the_dark_side.bash
```

### Manuellement

Il faut télécharger le super script [the_dark_side.bash](https://raw.githubusercontent.com/L0L022/config_iut/master/the_dark_side.bash) (clique droit -> Enregistrer la cible du lien sous) et le mettre dans le net_home ou une clef usb. Après il ne reste plus qu'a l'exécuter et le tour est joué ! La **magie vaudou** (ou bash pour les connaisseurs) prend (normalement) moins d'une demie minute pour faire son effet.

## Les changements de l'environnement de bureau

Ce qui saute d'abord aux yeux c'est le nouveau thème [Arc](https://github.com/horst3180/Arc-theme) tellement trop **dark**.

Atom devient l'éditeur de texte pas défaut.

Ajout de raccourcies vers les applications les plus utilisées sur le bureau:
- le super site web
- atom
- firefox/chromium
- scilab

## ATOM !!!!

Atom est un éditeur de texte qui a un système de paquet (plugins ou extensions) qui lui permet d'être totalement personnalisable et donc parfaitement adapté à n'importe quelle situation. En somme c'est *notepad++* puissance *sublime text*.

Pour savoir comment utiliser toutes ces supers extensions citées plus bas, il suffit de cliquer sur le lien qui renvoie aux explications des développeurs; vraiment trop facile.

### BASH *(pour les vrais hommes)*

[linter-shellcheck](https://atom.io/packages/linter-shellcheck): Extension qui utilise [shellcheck](https://github.com/koalaman/shellcheck) pour juger ton code ! Comme Loïc mais en plus rapide. *(Mais ça reste qu'une extension.)*

### BDD

[data-atom](https://atom.io/packages/data-atom): Pour exécuter les requêtes sql sans quitter atom (au revoir phppgadmin).
![data-atom](https://cloud.githubusercontent.com/assets/156625/15249612/ccd377b0-1963-11e6-88ad-42eee914fc38.gif)

### C++

[linter-gcc](https://atom.io/packages/linter-gcc): Affiche les insultes de gcc directement dans atom !
![linter-gcc](https://raw.githubusercontent.com/hebaishi/images/master/lintergcc_onthefly.gif)

### Web *(pour les MMI)*

[atom-bootstrap3](https://atom.io/packages/atom-bootstrap3): Ajoute l'auto-complétion pour bootstrap 3.
![atom-bootstrap3](https://dl.dropboxusercontent.com/u/20947008/webbox/atom/atom-bootstrap-3.gif)

[atom-html-preview](https://atom.io/packages/atom-html-preview): Affiche la page web dans atom et elle s'actualise toute seule !
![atom-html-preview](https://dl.dropboxusercontent.com/u/20947008/webbox/atom/atom-html-preview.png)

[color-picker](https://atom.io/packages/color-picker): Permet de sélectionner une couleur sans se casser la tête.
![color-picker](https://github.com/thomaslindstrom/color-picker/raw/master/preview.gif)

[linter-htmlhint](https://atom.io/packages/linter-htmlhint): Affiche les erreurs html.

[linter-stylelint](https://atom.io/packages/linter-stylelint): Affiche les erreurs css.
![linter-stylelint](https://raw.githubusercontent.com/AtomLinter/linter-stylelint/master/demo.png)

[random](https://atom.io/packages/random): Donne des noms, phrases, paragraphes et plein d'autre trucs au hasard. Le latin c'est has-been.
![random](https://cdn.rawgit.com/RichardSlater/atom-random/v0.1.4/assets/screenshot.gif)

[webbox-color](https://atom.io/packages/webbox-color): Affiche les couleurs derrière les codes couleurs. Pour ceux qui ne savent toujours pas lire l'hexadécimal.
![webbox-color](https://dl.dropboxusercontent.com/u/20947008/webbox/atom/atom-color-3.png)

### Autre

[git-plus](https://atom.io/packages/git-plus): Pour exécuter les commandes git depuis atom.
![git-plus](https://raw.githubusercontent.com/akonwi/git-plus/master/commit.gif)

[script](https://atom.io/packages/script): Lance script bash et compile/lance fichier cpp sans passer par le terminal. ***Attention: saisie utilisateur non prise en charge.***

## Oui Loïc moi j'aime pas trop ça, tu vois ça serait mieux comme ça, gnagnagna...

Et oui, malheureusement certains ne vont pas aimer le côté trop dark de **The Dark Side** ou le très très beau fond d'écran I LOVE BASH. Comme je suis quelqu'un de très gentil j'ai fait en sorte que tout le monde puisse avoir leur propre **The Dark Side**.

### Comment ?!

Envoyez moi un mail (adresse iut) avec votre **identifiant ametice**, des **explications claires** et **plein de liens**.

Ceux qui connaissent github peuvent passer directement par des pull request. Le script a modifier est crazy_patch.bash.

### Exemple

Monsieur @bohrin a son propre fond d'écran avec en plus le raccourci chromium supprimé de son bureau, car google c'est le mal.
