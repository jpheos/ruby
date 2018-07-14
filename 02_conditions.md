# Conditions

### Comparaisons simples

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

Retourne **0** si `x = y`, **1** si `x > y` et **-1** si `x < y`.

### Comparaisons multiples

```ruby
a == b && c == d
```

Retourne **true** si `a = b` **et** `c = d` et retourne **false** si une des deux conditions n'est pas respectée.

```ruby
a == b || c == d
```

Retourne **true** si `a = b` **ou** `c = d` et retourne **false** si aucune des deux conditions n'est respectée.

Il est évidemment possible de tester plus de conditions :

```ruby
a == b || c == d || e == f || g == h
```

Il est aussi possible de regrouper les conditions :

```ruby
( a == b || c == d ) && ( e == f || g == h )
```

Retourne **true** si, dans le bloc () de gauche, une des deux conditions au moins est vraie **et si**, dans le bloc () de droite, une des deux conditions au moins est vraie. Autrement dit, retourne **true** si les blocs () retournent tous les deux **true**.

