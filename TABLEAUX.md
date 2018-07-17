> ARRAYS

# Lecture et modification des valeurs

**[indice]**

Retourne les valeurs aux indices donnés.

```ruby
[1, 2, 3, 4][0] #=> 1
[1, 2, 3, 4][1] #=> 2
[1, 2, 3, 4][-1] #=> 4 (dernière valeur du tableau)
[1, 2, 3, 4][4] #=> nil (hors du tableau)
[1, 2, 3, 4][1, 2] #=> [2, 3]
[1, 2, 3, 4][1..3] #=> [2, 3, 4]
```

Il est possible d'assigner une nouvelle valeur.

```ruby
ary = [1, 2, 3, 4]
ary[0] = 9
ary #=> [9, 2, 3, 4]
```

**index**

Retourne l'indice d'une valeur donnée. Si la valeur apparaît plusieurs fois, l'indice correspondant à la première valeur trouvée est retourné.

```ruby
[1, 2, 3, 4].index(3) #=> 2
[1, 2, 1, 4, 1].index(1) #=> 0
```

**rindex**

Retourne l'indice d'une valeur donnée. Si la valeur apparaît plusieurs fois, l'indice correspondant à la dernière valeur trouvée est retourné.

```ruby
[1, 2, 3, 4].rindex(3) #=> 2
[1, 2, 1, 4, 1].rindex(1) #=> 4
```

**first**

Retourne les valeurs à partir du premier indice.

```ruby
[1, 2, 3, 4].first #=> 1
[1, 2, 3, 4].first(3) #=> [1, 2, 3]
```

**last**

Retourne les valeurs à partir du dernier indice (en conservant l'ordre normal des données dans le tableau).

```ruby
[1, 2, 3, 4].last #=> 4
[1, 2, 3, 4](3) #=> [2, 3, 4]
```

**delete**

Supprime du tableau la valeur indiquée et retourne cette valeur.

```ruby
ary = [1, 2, 3, 4]
ary.delete(2) #=> 2
ary #=> [1, 3, 4]
```

**delete_at**

Supprime du tableau la valeur à l'indice indiqué et retourne cette valeur.

```ruby
ary = [1, 2, 3, 4]
ary.delete_at(2) #=> 3
ary #=> [1, 2, 4]
```

**delete_if**

Supprime du tableau les valeurs correspondant aux conditions et retourne ces valeurs.

```ruby
ary = [1, 2, 3, 4]
ary.delete_if { |element| element > 2 } #=> [3, 4]
ary #=> [1, 2]
```

# Informations sur le tableau

**length, size ou count**

Retourne le nombre de valeurs.

```ruby
[1, 2, 3, 4].length #=> 4
[1, 2, 3, 4].size #=> 4
[1, 2, 3, 4].count #=> 4
```

**count**

Retourne le nombre de valeurs correspondant à la condition.

```ruby
[1, 2, 1, 4, 1].count(1) #=> 3
[1, 2, 3, 4].count { |element| element < 3 } #=> 2
```

**empty?**

Retourne **true** si le tableau est vide.

```ruby
[1, 2, 3, 4].empty? #=> false
```

**include?**

Retourne **true** si le tableau contient l'élément passé en argument.

```ruby
[1, 2, 3, 4].include?(1) #=> true
[1, 2, 3, 4].include? 1 #=> true (autre écriture)
[1, 2, 3, 4].include?(5) #=> false
```

# Méthodes portant sur le tableau

**compact**

Retourne un tableau sans les valeurs nulles (*nil*).

```ruby
["a", nil, "b", nil, "c", nil ].compact #=> [ "a", "b", "c" ]
```

**sort**

Retourne un tableau trié par valeurs.

```ruby
[1, 3, 2, 4].sort #=> [1, 2, 3, 4]
[1, 3, 2, 4].sort { |a, b| a <=> b } #=> [1, 2, 3, 4]
[1, 3, 2, 4].sort { |a, b| b <=> a } #=> [4, 3, 2, 1]
```

**shuffle**

Retourne un tableau trié aléatoirement.

```ruby
[1, 2, 3, 4].shuffle #=> [3, 2, 1, 4] (aléatoire)
```

**join**

Retourne un *string*.

```ruby
["a", "b", "c"].join #=> "abc"
```

**reverse**

Retourne un tableau inversé.

```ruby
[1, 2, 3, 4].reverse #=> [4, 3, 2, 1]
```

**uniq**

Retourne un tableau de valeurs uniques.

```ruby
[1, 1, 2, 2, 2, 3, 4, 4].uniq #=> [1, 2, 3, 4]
```

**sample**

Retourne des valeurs tirées aléaoirement.

```ruby
[1, 2, 3, 4].sample #=> 3 (aléatoire)
[1, 2, 3, 4].sample(2) #=> [4, 2] (aléatoire)
```

**combination**

Retourne les combinaisons possibles avec les valeurs du tableau (par exemple les tirages possibles). Le paramètre précise le nombre de valeurs dans la combinaison (par exemple 4 pour 4 tirages). Les combinaisons sont triées et ne prennent pas compte de l'ordre donc on trouvera `[1, 2, 3]` mais pas `[1, 3, 2]`.

Les données sont renvoyées sous forme d'un *enumerator*, il faut donc utiliser `to_a` pour retourner un tableau de tableaux.

```ruby
[1, 2, 3, 4].combination(3).to_a #=> [[1, 2, 3], [1, 2, 4], [1, 3, 4], [2, 3, 4]]
```

Il existe aussi une méthode plus complexe `repetead_combination`.

**permutation**

Retourne les permutations possibles avec les valeurs du tableau (par exemple les codes possibles d'un digicode). Le paramètre précise le nombre de valeurs dans la permutation (par exemple 4 pour un code à 4 chiffres). Les combinaisons sont triées et mais prennent en compte l'ordre donc on trouvera `[1, 2, 3]` et `[1, 3, 2]`.

Les données sont renvoyées sous forme d'un *enumerator*, il faut donc utiliser `to_a` pour retourner un tableau de tableaux.

```ruby
[1, 2, 3, 4].combination(3).to_a #=> [[1, 2, 3], [1, 2, 4], [1, 3, 2], [1, 3, 4], [1, 4, 2], [1, 4, 3], [2, 1, 3], [2, 1, 4], [2, 3, 1], [2, 3, 4], [2, 4, 1], [2, 4, 3], [3, 1, 2], [3, 1, 4], [3, 2, 1], [3, 2, 4], [3, 4, 1], [3, 4, 2], [4, 1, 2], [4, 1, 3], [4, 2, 1], [4, 2, 3], [4, 3, 1], [4, 3, 2]]
```

Il existe aussi une méthode plus complexe `repetead_permutation`.

# Méthodes portant sur chaque élément du tableau

**each**

Lit chaque case du tableau et effectue des actions.

```ruby
[1, 2, 3, 4].each do |element|
  # do something with each 'element'
  print element
end
#=> console : '1234'
```

**each_with_index**

Lit chaque case du tableau en incluant l'index et effectue des actions.

```ruby
[1, 2, 3, 4].each do |element, i|
  # do something with each 'element'
  print " index #{i}: #{element} "
end
#=> console : ' index 0: 1  index 1: 2  index 2: 3  index 3: 4 '
```

**reverse_each**

Même méthode que `each` mais dans le sens inverse.

```ruby
[1, 2, 3, 4].reverse_each do |element|
  # do something with each 'element'
  print element
end
#=> console : '4321'
```

**map / collect**

Retourne un tableau avec les modifications indiquées.

```ruby
[1, 2, 3, 4].map do |element|
  # do something witch each 'element'
  element * 2
end
#=> [2, 4, 6, 8]
```

**select**

Retourne un tableau qui ne prendra que les valeurs correspondant à la condition.

```ruby
[1, 2, 3, 4].reject do |element|
  # condition on 'element'
  element < 3
end
#=> [1, 2]
```

**reject**

Opposé de *select* : retourne un tableau qui ne prendra que les valeurs ne correspondant pas à la condition.

```ruby
[1, 2, 3, 4].reject do |element|
  # condition on 'element'
  element < 3
end
#=> [3, 4]
```

# Méthodes comparant des tableaux

**&**

Retourne un tableau contenant les valeurs communes aux deux tableaux. L'ordre des tableaux importe.

```ruby
[1, 2, 3, 4] & [4, 2, 7, 6] #=> [2, 4]
[4, 2, 7, 6] & [1, 2, 3, 4] #=> [4, 2]
```

**-**

Retourne un tableau contenant les valeurs du premier tableau sauf celles existant dans le deuxième. L'ordre des tableaux importe.

```ruby
[1, 2, 3, 4] - [4, 2, 7, 6] #=> [1, 3]
[4, 2, 7, 6] - [1, 2, 3, 4] #=> [7, 6]
```

# Informations diverses sur les tableaux et méthodes

Les méthodes portant sur chaque valeur peuvent s'écrire en une ligne (*inline*) :

```ruby
[1, 2, 3, 4].method { |element| "do something with #{element}" }
```

Les méthodes retournent quasiment toutes un nouveau tableau. Pour modifier directement le tableau, il suffit de suivre la méthode d'un `!`. Cette technique marche pour quasiment toutes les méthodes.

```ruby
ary = [1, 2, 3, 4]
ary.reverse
ary #=> [1, 2, 3, 4]
ary.reverse!
ary #=> [4, 3, 2, 1]
```

En pratique, toutes les méthodes pourraient être remplacées par la méthode `each` avec quelques lignes de code supplémentaires.

Par exemple, les deux méthodes ci-dessous retournent le même tableau :

```ruby
# Avec la méthode each : 3 lignes, 52 caractères
new_ary = []
[1, 2, 3, 4].each { |e| new_ary << e * 2 }
new_ary #=> [2, 4, 6, 8]

# Avec la méthode map : 1 ligne, 31 caractères
new_ary = [1, 2, 3, 4].map { |e| e * 2 }  => [2, 4, 6, 8] #=> [2, 4, 6, 8]
```

Idem pour les deux méthodes ci-dessous :

```ruby
# Avec la méthode each : 3 lignes, 57 caractères
new_ary = []
[1, 2, 3, 4].each { |e| new_ary << e if e < 3 }
new_ary #=> [1, 2]

# Avec la méthode select : 1 ligne, 34 caractères
new_ary = [1, 2, 3, 4].select { |e| e < 3 } #=> [1, 2]
```
