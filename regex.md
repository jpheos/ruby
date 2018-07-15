# Expressions régulières

L'outil [Rubular](http://rubular.com/) permet de tester rapidement une expression régulière.

Ces expressions permettent de tester si une valeur correspond exactement :
```ruby
/a/ # "a"
/ab/ # "ab"
```

Ces expressions permettent d'ajouter une notion de quantité :
```ruby
/abc?/ # "ab" et 0 ou 1 fois "c" / Exemples : "ab", "abc"
/abc*/ # "ab" et 0 ou x fois "c" / Exemples : "ab", "abc", "abccc"
/abc+/ # "ab" et 1 ou x fois "c" / Exemples : "abc", "abccc"
/abc{2}/ # "ab" et 2 fois "c" / Exemples : "abcc"
```
*?* signifie 0 ou 1, *\** signifie 0 ou plus, *+* signifie 1 ou plus.
L'expression *{}* indique un nombre exact à respecter.

Une *pipes* `|` permet d'ajouter un **ou**
```ruby
/a|b/ # "a" ou "b" / Exemples : "a", "b"
```

Les expressions peuvent être groupées avec des `()` :
```ruby
/(abc)+/ # 1 ou x fois "abc" / Exemples : "abc", "abcabc"
/(a|b)c/ # "a" ou "b" et "c" / Exemples : "ac", "bc"
```

Une *range* `[]` permet d'intégrer une pluralité de caractères :
```ruby
/[abc]/ # "a", "b" ou "c" / Exemples : "a", "b", "c", "ab", "ac", "bc", "abc"
/[a-z]/ # N'importe quelle lettre en minuscule / Exemples : "a", "e", "hello"
/[A-Z]/ # N'importe quelle lettre en majuscule / Exemples : "A", "E", "HELLO"
/[a-zA-Z]/ # N'importe quelle lettre / Exemples : "a", "E", "HeLLo"
/[01]/ # 0 ou 1 / Exemples : 0, 1, 10, 101
/[0-9]/ # N'importe quel chiffre entre 1 et 9 / Exemples : 1, 5, 15, 2379
```

Les *ranges* et les quantités peuvent être cumulées :
```ruby
/[a-zA-Z]{2}/ # N'importe quelle lettre deux fois / Exemples : "ab", "eZ"
/[a-zA-Z]{2}/ # N'importe quel chiffre deux fois / Exemples : "12", "38"
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
/[1-9&&[^5]]/ # N'importe quel chiffre sauf 5 / Exemples : 1, 13
/[^a-b]/ # N'importe quel caractère sauf "a" ou "b" / Exemples : "e", "ij", 12
 ```

La présence d'un *espace* se contrôle avec `\s` :
```ruby
/\s/ # Une expression contenant un espace / Exemples : "a b"
 ```

Les *ancres* `^` et `$` contrôlent le début et la fin d'une expression :
```ruby
/^la/ # Une expression commençant par "la" / Exemples : "lapin"
/la$/ # Une expression finissant par "la" / Exemples : "cola"
 ```

Le signe `\b` (*boundaries*) permet de vérifier la présence de charactères à une position donnée  :
```ruby
/\bla/ # N'importe quel mot commence par "la" / Exemples : "lapin"
/la\b/ # N'importe quel mot finissant par "la" / Exemples : "cola"
/\bla\b/ # Une expression contenant "la" sans charactère ou chiffre avant ou après / Exemples : "à la plage", "la-la-land"
 ```
