# Expressions régulières

L'outil [Rubular](http://rubular.com/) permet de tester rapidement une expression régulière.

### Généralités

Les Regex sont utiles pour vérifier du texte entré par l'utilisateur (un email...) ou analyser du texte (compter l'occurence d'un mot...).

Les Regex s'écrivent entre deux `/` par convention, mais il est possible de les encadrer avec d'autres caractères, par exemple `%` :
```ruby
/[a-z]/ # Regex indiquant que l'expression doit être une lettre minuscule entre "a" et "z" pour matcher
```

### Codes Regex

Ces expressions permettent de tester si une valeur correspond exactement :
```ruby
/a/ # Expression contenant "a" / Exemples : "chat", "1c!ra34"
/ab/ # Expression contenant "ab" / Exemples : "abricot", "12abc45"
```

Ces expressions permettent d'ajouter une notion de quantité :
```ruby
/ab?c/ # "a", éventuellement "b" (0 ou 1 fois) et "c" / Exemples : "abc", "ac"
/ab*c/ # "a", éventuellement "b" (0 ou x fois) et "c" / Exemples : "abc", "ac", "abbbc"
/ab+c/ # "a", au moins 1 "b" et "c" / Exemples : "abc", "abbbc"
/ab{2}c/ # "a", 2 "b" et "c" / Exemples : "abbc", "aaabbccc"
/ab{2,}c/ # "a", au moins 2 "b" et "c" / Exemples : "abbc", "abbbc"
/ab{2,4}c/ # "a", entre 2 et 4 "b" et "c" / Exemples : "abbc", "abbbc", "abbbbc"
```
*?* signifie 0 ou 1, *\** signifie 0 ou plus, *+* signifie 1 ou plus.
L'expression *{}* indique une quantité plus précise.

Une *pipes* `|` permet d'ajouter un **ou**
```ruby
/a|b/ # "a" ou "b" / Exemples : "a", "b"
```

Les expressions peuvent être groupées avec des `()` et inclure des **ou** avec `|` :
```ruby
/(abc)+/ # 1 ou x fois "abc" / Exemples : "xxxabcxxx", "xxxabcabcxxx"
/(a|b)c/ # "a" ou "b" et "c" / Exemples : "ac", "bc"
```

Une *range* `[]` permet d'intégrer une pluralité de caractères :
```ruby
/[abc]/ # "a", "b" ou "c" / Exemples : "a", "b", "c", "ab", "ac", "bc", "abc"
/[a-z]/ # "a", "b" ... "z" / Exemples : "a", "e", "hello"
/[A-Z]/ # "A", "B" ... "Z" / Exemples : "A", "E", "HELLO"
/[a-zA-Z]/ # A", "B" ... "Z", "a", "b" ... "z" / Exemples : "a", "E", "HeLLo"
/[01]/ # 0 ou 1 / Exemples : 0, 1, 10, 101
/[0-9]/ # 1, 2 ... ∞ / Exemples : 1, 5, 15, 2379
```
Le signe `-` indique qu'il s'agit d'une *range* (*de ... à ...*).

Les *ranges* et les quantités peuvent être cumulées :
```ruby
/[a-zA-Z]{2}/ # N'importe quelle lettre deux fois / Exemples : "ab", "eZ"
 ```

Certains *ranges* peuvent s'écrire plus rapidement :
```ruby
/\d/ # équivaut à [0-9] / Exemples : 1, 5, 15, 2379
/\w/ # équivaut à [a-zA-Z0-9_] / Exemples : 1, "a", "G", "Hello"
/\W/ # équivaut à [^a-zA-Z0-9_] / Exemples : "!", "$"
```

Le signe `^` extrait une possibilité (**sauf**) :
```ruby
/[^5]/ # N'importe quel caractère sauf 5 / Exemples : "a", "abc", 138
/[[1-9]&&[^5]]/ # N'importe quel chiffre sauf 5 / Exemples : 1, 15
/[^a-b]/ # N'importe quel caractère sauf "a" ou "b" / Exemples : "e", "ij", 12
 ```

La présence d'un *espace* se contrôle avec `\s` :
```ruby
/\s/ # Une expression contenant un espace / Exemples : "a b"
 ```

Les *ancres* `^` et `$` contrôlent le début et la fin d'une expression :
```ruby
/^la/ # Commence par "la" / Exemples : "lapin"
/la$/ # Finit par "la" / Exemples : "cola"
/^la.*nd$/ # Commence par "la" et finit par "nd" / Exemples : "lalaland"
 ```

Le signe `\b` (*boundaries*) permet d'indiquer le *bord* (**boundaries**) d'un mot :
```ruby
/\bla/ # N'importe quel mot commence par "la" / Exemples : "Un lapin dans un chapeau"
/la\b/ # N'importe quel mot finissant par "la" / Exemples : "cola"
/\bla\b/ # Une expression contenant "la" sans charactère ou chiffre avant ou après / Exemples : "à la plage", "la-la-land"
 ```
La signe `-` est traité de la même manière que l'espace, c'est-à-dire que le Regex considère que le mot "fleur" dans "chou-fleur" commence par "f", comme dans "chou fleur".

*A COMPLETER*

Les signes `\A` et `\z` testent le début ou la fin - respectivement - de la ligne :
```ruby
# ? A compléter
 ```


### Informations diverses

Par défaut, même s'il n'est pas indiqué, on considère qu'il y a `{1}` :
```ruby
/[abc]/
/[abc]{1}/ # Même Regex
 ```
}

### Test Regex

La comparaison `=~` permet de tester une correspondance, Ruby retournant l'indice auquel la première valeur est trouvée :
```ruby
"hello" =~ /l/ #=> 2 ("l" apparaît à la position 2)
 ```

Si aucun indice n'est trouvé, Ruby retourne `nil` :
```ruby
"hello" =~ /z/ #=> nil
 ```

Le signe `$` permet de retrouver le dernier *match* :
```ruby
"hello" =~ /h/ #=> 1
$~ #=> #<MatchData "h">
 ```

La méthode `#match` renvoit les informations sur le *match* :
```ruby
"hello".match(/h/) #=> #<MatchData "h">
 ```
Lorsqu'il y a des groupes, il est possible d'afficher les différents groupes avec un indice :
```ruby
"a3c".match(/([a-z])([0-9])([a-z])/) #=> #<MatchData "a3c" 1:"a" 2:"3" 3:"c">
"a3c".match(/([a-z])([0-9])([a-z])/)[0] #=> "a3c"
"a3c".match(/([a-z])([0-9])([a-z])/)[1] #=> "a"
"a3c".match(/([a-z])([0-9])([a-z])/)[2] #=> "3"
"a3c".match(/([a-z])([0-9])([a-z])/)[3] #=> "c"
"a3c".match(/([a-z])([0-9])([a-z])/)[4] #=> nil
 ```

Seules les données dans les groupes, donc dans les `()`, sont récupérables avec un indice :
```ruby
"a-3-c".match(/([a-z])-([0-9])-[a-z])/) #=> #<MatchData "a-3-c" 1:"a" 2:"3" 3:"c">
"a-3-c".match(/([a-z])([0-9])([a-z])/)[0] #=> "a-3-c"
"a-3-c".match(/([a-z])([0-9])([a-z])/)[1] #=> "a"
"a-3-c".match(/([a-z])([0-9])([a-z])/)[2] #=> "3"
"a-3-c".match(/([a-z])([0-9])([a-z])/)[3] #=> "c"
 ```

Les groupes peuvent être nommés pour être appelés :
```ruby
"a-3-c".match(/(?<one>[a-z])-(?<two>[0-9])-(?<three>[a-z])/) #=> #<MatchData "a-3-c" one:"a" two:"3" three:"c">
"a-3-c".match(/(?<one>[a-z])-(?<two>[0-9])-(?<three>[a-z])/)[:three] #=> "c"
 ```

La méthode `#scan` renvoit un tableau des *matchs* :
```ruby
"a-3-c b-1-d".scan(/(?<one>[a-z])-(?<two>[0-9])-(?<three>[a-z])/) # => [["a", "3", "c"], ["b", "1", "d"]]
 ```

### Utilisation des Regex

***A compléter***
*gsub*


