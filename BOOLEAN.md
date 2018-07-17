> BOOLEAN

# Comparaisons simples

```ruby
x == y
x != y
x > y
x < y
x >= y
x <= y
```
Retourne **true** si la condition est vraie, sinon **false**.

```ruby
x <=> y
```
Retourne **0** si x = y, **1** si x > y et **-1** si x < y.

# Comparaisons multiples

```ruby
a == b && c == d
```
Retourne **true** si a = b **et** c = d et retourne **false** si une des deux conditions n'est pas respectée.

```ruby
a == b || c == d
```
Retourne **true** si a = b **ou** c = d et retourne **false** si aucune des deux conditions n'est respectée.

Il est évidemment possible de tester plus de conditions :
```ruby
a == b || c == d || e == f || g == h
```
Il est aussi possible de regrouper les conditions :

```ruby
( a == b || c == d ) && ( e == f || g == h )
```
Retourne **true** si, dans le bloc `()` de gauche, une des deux conditions au moins est vraie **et si**, dans le bloc `()` de droite, une des deux conditions au moins est vraie. Autrement dit, retourne **true** si les blocs `()` retournent tous les deux **true**.

# Comparaisons spéciales

Ruby permet d'écrire autrement certains comparaisons récurrentes. Par exemple :
```ruby
i == 0
i.zero?
```
Retourne **true** si i = 0, la méthode `#zero?` sur un *integer* permettant de tester si un nombre vaut zéro.

Il existe d'autres méthodes pour vérifier une condition - donc retourner **true** ou **false** - sur différents types d'objets.
Ces méthodes sont faciles à reconnaître, elle finissent par un `?`.

```ruby
"hello".empty? #=> false
[1, 2].empty? #=> false
{key: "value"}.empty? #=> false
```
La méthode `#empty?` s'applique sur un objet *string*, *array* ou *hash* pour vérifier si l'objet est vide.
La méthode retourne **true** si l'objet est vide, sinon **false**.

```ruby
"hello".include? "h" #=> true
"hello".include?("h") #=> true
["a", "b"].include? "a" #=> true
["abc", "def"].include? "a" #=> false
{key: "value"}.include? :key #=> true
{key: "value"}.include? "value" #=> false
```
La méthode `#include?` retourne **true** si l'objet contient la valeur indiquée en paramètre.
Celle-ci peut être indiquée avec un espace `"hello".include? "h"` ou avec des parenthèses `"hello".include?("h")`.
`"hello".include? "h"` retourne **true** si la chaîne de caractères *hello* contient la lettre *h*.

`["a", "b"].include? "a"` retourne **true** car le tableau contient la valeur "a". `["abc", "def"].include? "a"` retourne **false** car aucune des valeurs n'est "a", même si l'une des valeurs contient la lettre *a*. Pour vérifier cela, il faudrait utiliser une boucle `#each` et tester chacune des valeurs avec `#include?` : `["abc", "def"].map { |e| e.include? "a" }` retourne un tableau contenant les valeurs **true** ("abc" contient "a") et **false** ("def" ne contient pas "a").


Sur un `hash`, la méthode `#include?` retourne **true** si la clé indiquée en paramètre existe. `{key: "value"}.include? :key` retourne donc **true** car la clé :key existe mais `{key: "value"}.include? "value"` retourne *false* car la clé "value" n'existe pas, même si la valeur "value" existe. La méthode `#key?` est plus adaptée à un *hash* et la méthode `#value?` permet de chercher une valeur (*infra*).

```ruby
"abc".start_with? "a" #=> true
"abc".end_with? "c" #=> true
```
Les méthodes `#start_with?` et `#end_with?` retournent **true** si un objet *string* commence ou fini - respectivement - par la lettre indiquée en argument.

```ruby
1.odd? #=> true
2.even? #=> true
```
Les méthodes `#odd?` et `#even?` retournent **true** si un objet *integer* est - respectivement - impair ou pair.

```ruby
{key: "value"}.key? :key #=> true
{key: "value"}.value? "value" #=> true
```
Les méthodes `#key?` et `#value?` retournent **true** si un objet *hash* contient une clé ou une valeur - respectivement - correspondant au paramètre indiqué. Les méthodes `#has_key?` et `#has_value?` fonctionnent aussi et font exactement la même chose mais il semble préférable de ne pas les utiliser (méthodes dépréciées).

Il doit y avoir une centaine de méthodes retournant **true** ou **false**, d'après la documentation *Ruby*. Le plus simple pour les voir est d'aller sur [la documentation *Ruby*](https://ruby-doc.org/core-2.5.1/) et d'indiquer "?" dans la barre de recherche des méthodes.

# *To be continued...*
