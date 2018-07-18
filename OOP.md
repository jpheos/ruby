> OOP (OBJECT-ORIENTED PROGRAMMING)

# Théorie générale

Ruby est un langage dit **orienté objet**. Ainsi, **tout** dans Ruby est un objet, qu'il s'agisse d'un objet de base (un *integer*, un *array*) ou créé par la suite (*infra*).

Les objets sont créés à partir des **classes**. Les classes sont conceptuelles et les objets sont concrets.

Par exemple, *array* est une classe, un concept, tandis que les arrays [0, 1, 2] et ["a", "b"] sont des objets de la classe *array*, ils existent réellement.

Les classes définissent des méthodes (*behavior*). Ainsi, un *array* est une liste de valeurs, pouvant être n'importe quel objet (*integer*, *string*) et étant indexées à partir de 0. Un *array* dispose aussi de propriétés

Petit paralèlle avec le monde réel : la voiture est un concept. Si on dit que la voiture a été inventée en 1769, on parle du concept de voiture et non d'une voiture réelle, physiquement présente, donc d'une *classe*.

Une voiture a des données et des méthodes : chaque voiture a une couleur, une taille... chaque voiture peut rouler, freiner...  Tous les *objets* de la *classe* voiture hériteront donc de ces données et méthodes.

Notre voiture garée en bas de la rue existe : c'est un *objet* de la classe voiture. Elle dispose donc des données couleur et taille (avec ses propres valeurs, par exemple 'rouge' et '200cm') et des méthodes rouler et freiner.

A noter que **instance** et **objet** signifient quasiment tout le temps la même chose. Il y a une petite différence (que je n'ai jamais comprise) mais qui importe peu pour développer...


# Création d'une classe

## Initialisation de la classe

Une nouvelle classe est créée avec `class ClassName`. Le nom de la classe s'écrit en *UperCamelCase* tandis que le nom du fichier qui contiendra la classe s'écrit en *snake_case.rb*. Un fichier *.rb* sera consacré à la classe.

```ruby
class Car
```

## Instanciation

La méthode `initialize` est une méthode spéciale définissant ce qui doit se passer lorsqu'une nouvelle instance de la classe est instanciée.

Ci-dessous, la méthode possèdent deux paramètres (`name_arg` et `color_arg`) ce qui signifie qu'un objet sera instancié en indiquant deux arguments, par exemple `my_car = Car.new("car1", "red")`.

La variable `@name` prendra la valeur de l'argument pour `name_arg` et la variable `@color` prendra la valeur de l'argument pour `color_arg`. La variable `color_arg` a ici une valeur "*white*" par défaut, au cas où elle ne sera pas définie. Ainsi, `my_car = Car.new("car2")` créera une voiture blanche.

Les variables `current_fuel` (carburant dans la voiture) et `max_fuel` (taille du réservoir) vaudront 50 et 100 pour toute nouvelle instance créée (une nouvelle voiture démarrant avec 50 litres de carburant sur une capacité de 100 dans notre exemple).

Enfin, la variable de classe `@@cars_count` (*infra*) est incrementée à chaque nouvelle instance créée afin de comptabiliser le nombre total d'instances créées.

```ruby
  def initialize(name_arg, color_arg=white)
    @name = name_arg
    @color = color_arg
    @current_fuel = 50
    @max_fuel = 100
    @@cars_count += 1 # cf. infra
  end
  ```

## Accès aux données

La manière dont les données sont accessibles de l'extérieur de la classe est définie par :
* `attr_reader` : la variable est accessible en lecture seule ;
* `attr_writer` : la variable est accessible en écriture seule ;
* `attr_accessor` : la variable est accessible en écriture et en lecture.

Les variables sont dans tous les cas accessibles en lecture et en écriture à l'intérieur de la classe.

Déterminer qui utilisera l'objet peut aider à savoir si une variable (ou une méthode, cf. *infra*) doit être accessible ou non. Dans notre exemple d'une voiture, il s'agit - notamment - du conducteur.

Ainsi, les variables `name`, `current_fuel` et `max_fuel` ne sont accessibles qu'en *lecture seule* : le conducteur ne peut en effet pas modifier le nom de sa voiture, la taille du résevoir ou le niveau de carburant (pas directement, il doit passer par la méthode de remplissage du réservoir (*infra*) pour cela). La variable `color` est en lecture et en écriture car le conducteur peut voir la couleur de sa voiture et - on suppose pour l'exemple - la repeindre directement.

Dans les *attr*, les noms des variables sont indiquées sans le `@` mais en symboles, donc avec `:`.

Généralement, ces éléments sont placés en première position dans la classe.

```ruby
  attr_reader :name, :current_fuel, :max_fuel
  attr_accessor :color
```

## Méthodes publiques et privées

Des méthodes s'appliquant à chacun des objets peuvent être créées.

Il faut précéder les méthodes de `public` pour qu'elles soient appellées de l'extérieur de la classe avec `instance_name.method_name`. Autrement dit, il faut imaginer qu'il s'agit d'actions que peut réaliser le conducteur de la voiture.

Les méthodes privées sont accessibles uniquement par les méthodes de la classe elle-même, et non à l'extérieur de la classe. Il s'agit des actions que ne peut pas faire directement le conducteur.

Dans l'exemple ci-dessous, le fait de faire le plein (`fill_it_up`) est réalisable par le conducteur. Il peut aussi décider de la quantité qu'il souhaite mettre (représentée par le paramètre `qty`). Par contre, ce qui se passe exactement quand il fait le plein est géré par la classe elle-même. Par exemple, si le réservoir est plein, le conducteur ne peut plus ajouter de carburant. Cette action de blocage du réservoir est gérée par la voiture elle-même et non par le conducteur. Il faut donc une fonction privée `manage_fill` pour définir ce qui se passe exactement quand le conducteur souhaite faire le plein. La fonction publique `fill_it_up` se contente donc de faire appelle à la fonction privée `manage_fill` en lui redonnant la quantité en attributs.

```ruby
  public

  def fill_it_up(qty) # Méthode permettant de faire le plein
    manage_fill(qty) # Appel de la méthode de gestion du réservoir
  end

  private

    def manage_fill(qty) # Méthode de gestion du réservoir
      space = @max_fuel - @current_fuel # Place restante dans le réservoir
      if space < qty # S'il n'y a pas assez d'espace pour la quantité demandée
        @current_fuel = @max_fuel # On remplit le réservoir
        puts "#{space} litres ont été ajoutés."
      else # S'il y a assez d'espace pour la quantité demandée
        @current_fuel += qty
        puts "#{qty} litres ont été ajoutés."
      end
      puts "Le réservoir est remplit à #{@current_fuel / @max_fuel}"
    end
```

## Variables et méthodes sur la classe

Il est aussi possible de définir des variables et méthodes qui s'appliquent sur la classe elle-même, et non sur chaque objet séparement. Typiquement, une variable *count* qui permet de comptabiliser le nombre d'instances créées. Les variables d'instances commencent par `@@`. Les méthodes portant sur la classe commencent par `self.`.

Ci-dessous, la variable `@@cars_count` permet de comptabiliser le nombre d'objets de cette classe (le nombre de voitures). La méthode `number_of_cars` peut être appelée à l'extérieur de la classe avec `Car.number_of_cars` et affichera le valeur de `@@cars_count`, soit le nombre d'instances créées (la méthode `initialize` ci-dessous incrémentant cette valeur à chaque nouvelle instance créée).

La variable `@@cars_count` n'ayant pas de `attr`, elle n'est pas accessible directement de l'extérieur de la classe. Il faudra passer par la méthode `number_of_cars` pour lire la valeur de `@@cars_count`.

Généralement, on place ces éléments au début de la classe, après la gestion des accès.

```ruby
  @@cars_count = 0
  def self.number_of_cars
    @@cars_count
  end
```

## Fin de la classe

On termine la classe.

```ruby
end
```

## En bloc

Ci-dessous, la classe précédente en un seul bloc.

```ruby
class Car

  # Gestion des accès

  attr_reader :name, :current_fuel, :max_fuel
  attr_accessor :color

  # Variables et méthodes de classe

  @@cars_count = 0
  def self.number_of_cars
    @@cars_count
  end

  # Instanciation d'un objet

  def initialize(name_arg, color_arg=white)
    @name = name
    @color = color
    @current_fuel = 50
    @max_fuel = 100

    @@cars_count += 1
  end

  # Méthodes d'objet publiques

  public

  def fill_it_up(qty) # Méthode permettant de faire le plein
    manage_fill(qty) # Appel de la méthode de gestion du réservoir
  end

  # Méthodes d'objet privées

  private

    def manage_fill(qty) # Méthode de gestion du réservoir
      space = @max_fuel - @current_fuel # Place restante dans le réservoir
      if space < qty # S'il n'y a pas assez d'espace pour la quantité demandée
        @current_fuel = @max_fuel # On remplit le réservoir
        puts "#{space} litres ont été ajoutés."
      else # S'il y a assez d'espace pour la quantité demandée
        @current_fuel += qty
        puts "#{qty} litres ont été ajoutés."
      end
      puts "Le réservoir est remplit à #{@current_fuel / @max_fuel.to_f}%"
    end

end
```

## Utilisation de la classe

De l'extérieur de la classe, par exemple dans un nouveau fichier *interface.rb*, on peut utiliser la classe.

```ruby
require_relative 'car.rb' # Récupération du fichier contenant la classe

car1 = Car.new("mercedes", "blue") # Création d'une instance

car1.name #=> "mercedes"
car1.color #=> "blue"

car1.color = "red" #=> La voiture est maintenant rouge
car1.name = "nissan" #=> Erreur, accès en écriture impossible à @name

car1.fill_it_up(10) #=> Ajoute 10 litres pour atteindre 60
car.manage_fill(10) #=> Erreur, la méthode est privée
```
