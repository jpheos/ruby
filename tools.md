# tools

Quelques outils et pratiques pour se faciliter la vie !

## IRB

IRB (*Interactive RuBy*) se lance dans le terminal avec la commande `irb`. La commande ouvre une console qui permet de tester directement du code Ruby.

Les retours sont automatiquement affichés, il n'y a donc pas besoin d'écrire `p`.

Pour quitter IRB et revenir au terminal, il faut taper `exit`.

```sh
➜ irb
[1] pry(main)> 1 + 1
=> 2
[2] pry(main)> "abc".class
=> String
[3] pry(main)> i = 0
=> 0
[4] pry(main)> i += 3
=> 3
[5] pry(main)> exit
➜
```

## Awesome print

La gem **Awesome Print** permet d'afficher d'une manière plus lisible les éléments. Elle est particulièrement utile pour l'affichage d'un *hash*. Dans le code, il suffit d'indiquer `ap` à la place de `p`.

[Voir la documentation de *Awesome Print*](https://github.com/awesome-print/awesome_print)

```ruby
require 'awesome_print'

hash = {
  "title": "Contacts",
  "contacts": [
    {
      "firstname": "John",
      "lastname": "Doe",
      "age": "30"
    },
    {
      "firstname": "Jane",
      "lastname": "Did",
      "age": "33"
    }
  ]
}

ap hash
```

Affichage dans le terminal avec `p hash` :
```bash
{:title=>"Contacts", :contacts=>[{:firstname=>"John", :lastname=>"Doe", :age=>"30"}, {:firstname=>"Jane", :lastname=>"Did", :age=>"33"}]}
```

Affichage dans le terminal avec `ap hash` :
```bash
{
       :title => "Contacts",
    :contacts => [
        [0] {
            :firstname => "John",
             :lastname => "Doe",
                  :age => "30"
        },
        [1] {
            :firstname => "Jane",
             :lastname => "Did",
                  :age => "33"
        }
    ]
}
```

## Pry

La gem **Pry** permet de débugguer le code en intégrant des points d'arrêt, c'est-à-dire des moments dans le code où le programme fera une pause, permettant d'observer l'état des variables.

[Voir la documentation de *Pry*](https://github.com/pry/pry)

La gem doit être intégrée avec `require` puis les points d'arrêt sont ajoutés au code avec `binding.pry`.

```ruby
require 'pry'

def some_method(string)
  reverse_words = []
  words_array = string.split("\s")
  binding.pry
  words_array.each do |word|
    reverse_words << word.reverse
    binding.pry
  end
  reverse_words
end

some_method('This is a sentence with a lot of words')
```
Lorsque ce code est exécuté dans le terminal, il s'arrête au premier point d'arrêt, c'est-à-dire lorsqu'il rencontre le code `binding.pry`. La flèche indique la prochaine ligne de code. La console IRB s'ouvre automatiquement.

```bash
➜ ruby awesome.rb

From: /home/edouard/Documents/Github/ruby/awesome.rb @ line 7 Object#some_method:

     3: def some_method(string)
     4:   reverse_words = []
     5:   words_array = string.split("\s")
     6:   binding.pry
 =>  7:   words_array.each do |word|
     8:     reverse_words << word.reverse
     9:     binding.pry
    10:   end
    11:   reverse_words
    12: end

[1] pry(main)>
```
Dans la console, il est possible de :
* voir la valeur d'une variable en tapant son nom ;
* exécuter le code jusqu'au prochain point d'arrêt en tapant `continue` ;
* exécuter la ligne de code suivante en tapant `next` ;
* si une méthode est appelée, "entrer" dans la méthode en tapant `step` ;
* quitter le programme en tapant `exit-program`.

Par exemple, en tapant le nom de la variable `words_array`, on obtient sa valeur :

```bash
[1] pry(main)> words_array
=> ["This", "is", "a", "sentence", "with", "a", "lot", "of", "words"]
```

En tapant `continue`, on se retrouve au prochain point d'arrêt, dans la boucle `each`. En retapant `continue` deux fois, on refait tourner deux fois la boucle. On peut alors regarder la valeur de la variable `reverse_words` et de constater que le tableau se remplit correctement.

```bash
[1] pry(main)> reverse_words
=> ["sihT", "si", "a"]
```

On peut enfin taper `exit-program` pour quitter le programme et revenir au terminal :

```bash
[2] pry(main)> exit-program
➜
```
