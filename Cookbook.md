# Fonctionnement de l'app Cookbook

## Concept général

On veut créer un programme qui gère des livres de recettes. On a donc des recettes et des livres qui regroupent ces recettes.

Dans l'exercice demandé, on ne crée et travaille que sur un seul livre de recettes, avec plusieurs recettes à l'intérieur.


## Ordre des actions

Dans l'ordre, il faut :

1. Écrire la classe *Recipe* - dans le fichier *recipe.rb* - qui définit une instance *recipe* (recette).

2. Écrire la classe *Cookbook* - dans le fichier *cookbook.rb* - qui regroupe les instances recettes (livre de recettes). C'est le **modèle** (*model*) dans la structure MVC.

3. Écrire la classe *Controller*,- dans le fichier *controller.rb* - qui gère les liens entre la vue et le modèle. C'est le **contrôleur** (*controller*) dans le modèle MVC.

4. Écrire la classe *View* - dans le fichier *view.rb* - qui gère l'affichage. C'est la **vue** (*view*) dans le modèle MVC.

5. Écrire la classe *Router* - dans le fichier *router.rb* - qui gère les allers-retours entre le contrôleur et la console (dans une boucle) et donc l'interaction avec le programme. *Ce fichier est déjà écrit dans l'exercice.*

6. Écrire un fichier *app.rb*, qui sera lancé dans le terminal. Il génère les instances *cookbook*, *controller* et *router* puis lance la méthode *run* de l'instance *router* (la boucle). *Ce fichier est déjà écrit dans l'exercice.*


## Modélisation d'une recette

On crée le fichier *recipe.rb*.

On introduit une classe *Recipe*.

```ruby
class Recipe
end
```

On écrit la méthode d'initialisation. Cette méthode est lancée automatiquement lors de la création d'une instance avec `Recipe.new`.

```ruby
class Recipe
  def initialize
  end
end
```

On ajoute deux variables d'instance :
* `@name` pour le nom de la recette ;
* `@description` pour la description de la recette.

```ruby
class Recipe
  def initialize
    @name
    @description
  end
end
```

La valeur de ces variables sera indiquée lors de la création de l'instance avec des arguments : `Recipe.new(name, description)`. Il faut donc ajouter deux paramètres à la méthode *initialize* et indiquer que les variables correspondront aux arguments indiqués.

```ruby
class Recipe
  def initialize(name, description)
    @name = name
    @description = description
  end
end
```

Enfin, comme on souhaite pouvoir afficher ces informations à l'utilisateur par la suite, on ajoute un `attr_reader`.

```ruby
class Recipe
  attr_reader :name, :description
  def initialize(name, description)
    @name = name
    @description = description
  end
end
```


## Modélisation du Cookbook (le modèle)

On crée le fichier *cookbook.rb*.

On introduit une classe *Cookbook*.

```ruby
class Cookbook
end
```

On écrit la méthode d'initialisation. Cette méthode est lancée automatiquement lors de la création d'une instance avec `Recipe.new`.

```ruby
class Cookbook
  def initialize
  end
end
```

Une instance de la classe *Cookbook* regroupe des recettes, chaque livre de recettes (on n'en gère qu'un ici) aura donc pour données un regroupement de recettes. Un groupement en Ruby est représenté par un tableau qui regroupe des instances. Ici, les instances du tableau sont de la classe *Recipe*.

Comme nous souhaitons importer les recettes via un fichier CSV, nous créons d'abord un tableau vide, qui servira de receptacle aux données issues du CSV.

```ruby
class Cookbook
  def initialize
    @recipes = [] # Les instances recettes seront sotckés ici
  end
end
```

Chaque livre de recettes (chaque instance de *Cookbook*) dispose d'un fichier CSV qui contient la liste des recettes (bien qu'ici on ne traite qu'un livre de recettes donc qu'un fichier CSV). Le chemin vers le fichier CSV est donc une donnée importante pour une instance de *Cookbook*. Le chemin sera indiqué en argument lorsque l'instance de *Cookbook* sera créée.

```ruby
class Cookbook
  def initialize(csv_path_file)
    @recipes = [] # Les instances recettes seront sotckés ici
    @csv = csv_path_file
  end
end
```

Ce qu'on souhaite, c'est qu'au moment où l'on crée le livre de recette, les données correspondant à ce livre de recettes soient :
* récupérées dans le fichier CSV correspondant au livre de recettes concernés ;
* transformées du format CSV en instances de *Recipe* ;
* stockées dans la variable *recipes* du livre de recettes.

Cela représente beaucoup d'actions... on crée donc une méthode dédiée dans la classe qu'on appelle *import_csv*.

Les étapes :
1. les options d'importation sont définies dans la variable `csv_options` ;
2. on utilise la méthode `foreach` de la librairie 'csv' qui permet de réaliser une action sur chaque ligne (`row`) ;
3. pour chaque ligne du CSV, on crée une nouvelle instance de la classe *Recipe* en passant en argument le nom et la description et on le stocke dans une variable `recipe` (le nom est la première valeur de la ligne et la description la deuxième valeur de la ligne dans le fichier CSV) ;
4. on ajoute l'instance `recipe` dans le tableau `recipes` ;
5. on termine la boucle quand il n'y a plus de ligne dans le fichier CSV (`end`) ;
6. on termine la méthode d'import (`end`).

```ruby
def import_csv
  csv_options = { col_sep: ',', quote_char: '"' }
  CSV.foreach(@csv, csv_options) do |row|
    recipe = Recipe.new(row[0], row[1])
    @recipes << recipe
  end
end
```

Comme on a utilisé une méthode de la librairie `csv`, il faut qu'un importe cette librairie :

```ruby
require 'csv'
```

Comme on a utilisé une méthode de classe `Recipe` (avec `Recipe.new`) on importe aussi le fichier *recipe* :

```ruby
require_relative 'recipe'
```

Notre méthode d'importation est prête. On veut maintenant qu'elle s'exécute lorsqu'on crée le livre de recettes, donc lors de l'initialisation. On appelle donc la méthode `import_csv` dans la méthode `initialize` :

```ruby
class Cookbook
  def initialize(csv_path_file)
    @recipes = []
    @csv = csv_path_file
    import_csv # appel de la méthode import_csv au moment de l'initialisation
  end
end
```

L'initialisation d'un livre de recettes est terminée ! Il faut maintenant définir les comportements de l'instance.

On ajoute une méthode qui retourne la liste des recettes, donc la variable `@recipes` :

```ruby
def all
  @recipes
end
```

On ajoute une méthode qui permet d'ajouter une recette. Cette méthode prend en argument la recette à ajouter et la stocke dans le tableau des recettes :

```ruby
def add_recipe(recipe)
  @recipes << recipe
end
```

On ajoute une méthode qui permet de supprimer une recette. Cette méthode prend en argument l'*index* dans le tableau des recettes de la recette à supprimer et supprime cette valeur du tableau des recettes :

```ruby
def remove_recipe(recipe_index)
  @recipes.delete_at(recipe_index)
end
```

Terminé ! Un seul problème : si on modifie le tableau des recettes en en ajoutant ou en en supprimant puis qu'on ferme le programme, les modifications ne seront pas conservées car nous n'avons pas modifié le fichier CSV. Il faut donc faire une méthode d'export...

La méthode d'export consiste à :
1. définir les options d'export et les stocker dans une variable `csv_options` ;
2. ouvrir le fichier CSV en indiquant : son chemin (`@csv`), la méthode d'écriture (`wb`) et nos options (`csv_options`) ;
3. pour chaque recette du tableau des recettes, l'écrire dans le fichier CSV après l'avoir transformée au bon format (d'une instance à un format *string*) ;
4. fermer le fichier CSV et terminer la méthode.

```ruby
def export_csv
  csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
  CSV.open(@csv, 'wb', csv_options) do |csv|
    @recipes.each do |recipe|
      csv << [recipe.name, recipe.description]
    end
  end
end
```

Maintenant, on veut que les données soient exportées dans le fichier CSV, autrement dit le mettre à jour, lorsqu'on modifie le tableau des recettes, c'est-à-dire quand on ajoute ou quand on supprime une recette. On fait donc appelle à cette méthode dans les méthodes concernées.

```ruby
def add_recipe(recipe)
  @recipes << recipe
  export_csv # ici
end

def remove_recipe(recipe_index)
  @recipes.delete_at(recipe_index)
  export_csv # ici
end
```

La classe *Cookbook* est prête. Au final on a :

```ruby
require 'csv'
require_relative 'recipe'

class Cookbook
  def initialize(csv_file_path)
    @recipes = []
    @csv = csv_file_path
    import_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    export_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    export_csv
  end

  private

  def import_csv
    csv_options = { col_sep: ',', quote_char: '"' }
    CSV.foreach(@csv, csv_options) do |row|
      recipe = Recipe.new(row[0], row[1])
      @recipes << recipe
    end
  end

  def export_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@csv, 'wb', csv_options) do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description]
      end
    end
  end
end

```

Maintenant que la classe *Cookbook* est prête à être utilisée, on va en créer une instance, autrement dit on va générer une instance (un livre de recettes) pour pouvoir l'utiliser...

Cela est déjà écrit dans le fichier *app.rb* pour l'exercice :

```ruby
cookbook = Cookbook.new(csv_file)
```

## Modélisation du contrôleur

Le but du contrôleur est de définir comment l'utilisateur va pouvoir interagir avec le modèle.

On crée le fichier *controller.rb*.

Le contrôleur étant lié aux autres classes et ayant besoin d'utiliser leurs méthodes de classe, on les importe :

```ruby
require_relative 'recipe'
require_relative 'cookbook'
require_relative 'view'
```

On introduit une classe *Controller*.

```ruby
class Controller
end
```

Le contrôleur fait le lien entre la vue et le modèle. Il faut imaginer qu'il y a plusieurs vues et plusieurs modèles, par exemple s'il y a d'autres types de livres que des livres de recettes (des romans, des dictionnaires...).

Il faut donc bien dire que le contrôleur des livres de recettes doit être lié au modèle des livres de recettes et à la vue des livres de recettes.

Le modèle (*cookbook*) est passé en argument lors de la création d'un contrôleur. Pour la vue, on va créer l'instance au moment de la création du contrôleur, donc dans la méthode d'initialisation. Créer le contrôleur créera donc automatiquement la vue correspondante.

```ruby
def initialize(cookbook)
  @cookbook = cookbook
  @view = View.new
end
```

On définit maintenant les méthodes, c'est-à-dire les interactions possibles par l'utilisateur :
* afficher les recettes ;
* ajouter une recette ;
* supprimer une recette.

Ces méthodes feront souvent appel à des méthodes de la vue, qu'on écrira après.

On définit la méthode d'affichage des recettes. Celle-ci récupère les données auprès du modèle avec sa méthode *all* et les stocke dans une variable `recipes` puis indique à la vue d'utiliser sa méthode *display* sur la variable `recipes`. La méthode *display* de la vue sera écrite après, dans la vue.

```ruby
def list
  recipes = @cookbook.all
  @view.display(recipes)
end
```

On définit la méthode d'ajout d'une recette. Le nom de la recette est récupéré grâce à la méthode *ask_recipe_name* de la vue et est stocké dans une variable `name` ; la description est récupérée grâce à la méthode *ask_recipe_description* de la vue et est stockée dans une variable `description`. Une fois ces données en sa possession, le contrôleur crée une nouvelle instance recette avec en argument les variables `name` et `description` et la stocke dans une variable `recipe`. Puis il utilise la méthode *add_recipe* du modèle avec la variable `recipe` en argument pour ajouter la recette.

```ruby
def create
  name = @view.ask_recipe_name
  description = @view.ask_recipe_description
  recipe = Recipe.new(name, description)
  @cookbook.add_recipe(recipe)
end
```

On définit la méthode de suppression d'une recette. On récupère la liste des recettes auprès du modèle et on la stocke dans une variable `recipes`. On utilise la méthode *display* de la vue en passant la variable `recipes` en argument. On récupère avec la méthode *ask_recipe_index* l'index de la recette à supprimer et on le stocke dans une variable `index`. On appelle la méthode *remove_recipe* du modèle en lui passant la variable `index` en argument.

```ruby
def destroy
  recipes = @cookbook.all
  @view.display(recipes)
  index = @view.ask_recipe_index
  @cookbook.remove_recipe(index)
end
```

La classe *Controller* est terminée.

Au final on a :

```ruby
require_relative 'recipe'
require_relative 'cookbook'
require_relative 'view'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    recipes = @cookbook.all
    @view.display(recipes)
  end

  def create
    name = @view.ask_recipe_name
    description = @view.ask_recipe_description
    recipe = Recipe.new(name, description)
    @cookbook.add_recipe(recipe)
  end

  def destroy
    recipes = @cookbook.all
    @view.display(recipes)
    index = @view.ask_recipe_index
    @cookbook.remove_recipe(index)
  end
end
```

On peut donc aller dans le fichier *app.rb* et créer une instance *controller* en lui passant en argument le *cookbook* créé précédemment. Cela est déjà écrit dans le fichier *app.rb* pour l'exercice :

```ruby
cookbook   = Cookbook.new(csv_file)
controller = Controller.new(cookbook)
```


## Modélisation de la vue

Dans le contrôleur, on a appellé des méthodes de la vue. Il faut donc les créer dans la classe *View*.

On crée le fichier *view.rb*.

On introduit une classe *View*.

```ruby
class View
end
```

Pour rappelle, dans le contrôleur, nous avions passé la main à la vue pour :
* afficher la liste des recettes (méthode *display(recipes)*)
* demander le nom de la recette lors d'un ajout (méthode *ask_recipe_name*);
* demander la description de la recette lors d'un ajout (méthode *ask_recipe_description*);
* demander le nom de la recette lors d'un ajout (méthode *ask_recipe_index*.

Il faut donc définir ces méthodes...

La méthode d'affichage des recettes reçoit de la part du contrôleur un tableau des instances recettes. Vu qu'on veut traiter et afficher **chaque** valeur du tableau et utiliser l'*index* (pour numéroter les recettes), on utilise la méthode `.each_with_index`. La méthode *each* retourne à chaque fois une instance (une recette), on récupère donc le nom de l'instance avec `recipe.name` et la description avec `recipe.description`, on ajoute l'index, et on affiche le tout dans la console. On ajoute 1 à l'index pour faciliter la lecture à l'utilisateur (éviter que la première recette porte le numéro 0).

```ruby
def display(recipes)
  recipes.each_with_index do |recipe, index|
    puts "#{index + 1} | #{recipe.name}: #{recipe.description}"
  end
end
```

La méthode pour récupérer le nom de la recette lors d'un ajout par l'utilisateur utilise la méthode `gets.chomp`.

```ruby
def ask_recipe_name
  puts "What's the recipe's name?"
  gets.chomp
end
```

La méthode pour récupérer la description est similaire.

```ruby
def ask_recipe_description
  puts "What's the recipe's description?"
  gets.chomp
end
```

Enfin, la méthode proposant à l'utilisateur d'indiquer l'*index* de la recette à supprimer utilise aussi un `gets.chomp`. Comme nous voulons récupérer un *integer*, on applique la méthode `to_i`.

Comme on a au préalable afficher les numéros à l'utilisateur en ajoutant 1 à l'*index* (pour afficher 1, 2, 3... au lieu de 0, 1, 2...) on enlève 1 pour revenir à notre *index* de base.

En résumé : lorsqu'on veut montrer les numéros d'*index* [0, 1, 2] à l'utilisateur on améliore la lecture en lui montrant [1, 2, 3]. Du coup, s'il choisit 2, on sait qu'en réalité cela correspond à l'*index* 1.

```ruby
def ask_recipe_index
  puts "Choisissez une recette en indiquant le numéro"
  gets.chomp.to_i - 1
end
```

La vue est terminée !

## Actions du router

La classe *Router* est déjà définie dans l'exercice.

Une instance *router* prend en argument un contrôleur et dispose notamment d'une méthode *route_action* qui propose à l'utilisateur d'interagir avec le livre de recettes. Les interactions passent toujours par le contrôleur.


## Lancement de l'app

L'app est lancée avec le fichier *app.rb*. Celui-ci est déjà écrit dans l'exercice.

On a déjà vu que des instances *cookbokk* et *controller* avaient été instanciés :

```ruby
 cookbook   = Cookbook.new(csv_file)
 controller = Controller.new(cookbook)
 ```

Un *router* est alors instancié puis la méthode *run* de ce *router* est lancée afin de démarrer le programme.

Il suffit de lancer ce fichier grâce au terminal pour démarrer le programme :

```bash
ruby app.rb
```

## Circuit général

Voyons ce qui se passe réellement quand l'utilisateur interagit.

La méthode *run* de l'instance *router* étant une boucle qui appelle à chaque fois la méthode *route_action*, l'utilisateur revient toujours à la liste des propositions.

```ruby
while @running
  display_tasks
  action = gets.chomp.to_i
  print `clear`
  route_action(action) # appel de la méthode ci-dessous
end
```

```ruby
def route_action(action)
  case action
  when 1 then @controller.list
  when 2 then @controller.create
  when 3 then @controller.destroy
  when 4 then stop
  else
    puts "Please press 1, 2, 3 or 4"
  end
end
```

### Affichage des recettes

Si l'utilisateur choisit 1, la méthode *list* de l'instance *controller* est appellée :

```ruby
when 1 then @controller.list
  ```

On va donc voir dans le fichier *controller.rb*. La méthode *list* appelle d'abord la méthode *all* de l'instance *cookbook* et stocke le retour dans une variable `recipes`.

```ruby
def list
  recipes = @cookbook.all # you're here
  @view.display(recipes)
end
```

On va donc voir le fichier *cookbook.rb*. La méthode *all* renvoit la variable d'instance *recipes*, c'est-à-dire un tableau regroupant tous les instances *recipe*.

```ruby
def all
  @recipes # you're here
end
```

On retourne dans la méthode d'où l'on venait, c'est-à-dire la méthode *list* du *controller* pour voir ce qui se passe après... Sur la deuxième ligne, la méthode *display* de l'instance *view* est appelée avec la variable *recipes* (donc le tableau des instances *recipe*) en argument.

```ruby
def list
  recipes = @cookbook.all
  @view.display(recipes) # you're here
end
```

On va donc voir le fichier *view.rb*. La méthode *display* affiche les informations importantes (index, nom et description) de chaque élément du tableau fournit en argument (le tableau des instances *recipe*), c'est-à-dire les informations de chaque recette.

```ruby
def display(recipes)
  recipes.each_with_index do |recipe, index|
    puts "#{index + 1} | #{recipe.name}: #{recipe.description}"
  end
end
```

On retourne dans la méthode d'où l'on venait, c'est-à-dire la méthode *list* du *controller* pour voir ce qui se passe après... rien, la méthode est finie (`end`).

```ruby
def list
  recipes = @cookbook.all
  @view.display(recipes)
end # you're here
```

On retourne dans la méthode d'où l'on venait, c'est-à-dire la méthode *route_action* du *router*. Celle-ci est aussi terminée. On retourne donc encore dans la méthode précédente, c'est-à-dire la méthode ùrun* du *router*.

```ruby
while @running
  display_tasks
  action = gets.chomp.to_i
  print `clear`
  route_action(action) # appel de la méthode ci-dessous
end
```

On est dans une boucle *while*, la variable *running* est toujours égale à *true*, donc on recommence en proposant une nouvelle action à l'utilisateur.

```
Chemin complet : router => controller => model => controller => view => controller => routeur
```
### Ajout d'une recette

Si l'utilisateur choisit 2, la méthode *create* du *controller* est appellée :

```ruby
when 2 then @controller.create
  ```

On va donc voir dans le fichier *controller.rb*. La méthode *create* appelle d'abord la méthode *ask_recipe_name* de l'instance *view* et stocke le retour dans une variable `name`.

```ruby
def create
  name = @view.ask_recipe_name # you're here
  description = @view.ask_recipe_description
  recipe = Recipe.new(name, description)
  @cookbook.add_recipe(recipe)
end
```

On va donc voir dans le fichier *view.rb*. La méthode *ask_recipe_name* retourne un *string* correspondant à ce qu'a proposé l'utilisateur comme nom de recette.

```ruby
def ask_recipe_name
  puts "What's the recipe's name?"
  gets.chomp
end
```

On retourne dans la méthode d'où l'on venait, c'est-à-dire la méthode *create* du *controller* pour voir ce qui se passe après... La méthode *ask_recipe_description* de l'instance *view* est appelée.

```ruby
def create
  name = @view.ask_recipe_name
  description = @view.ask_recipe_description # you're here
  recipe = Recipe.new(name, description)
  @cookbook.add_recipe(recipe)
end
```

On va donc voir dans le fichier *view.rb*. La méthode *ask_recipe_description* retourne un *string* correspondant à ce qu'a proposé l'utilisateur comme description de recette.

```ruby
def ask_recipe_description
  puts "What's the recipe's description?"
  gets.chomp
end
```

On retourne dans la méthode d'où l'on venait, c'est-à-dire la méthode *create* du *controller* pour voir ce qui se passe après... Une instance de la classe *Recipe* est créé avec `Recipe.new(name, description)`. Cela signifie que la méthode *initialize* de la classe *Recipe* est appelée.

```ruby
def create
  name = @view.ask_recipe_name
  description = @view.ask_recipe_description
  recipe = Recipe.new(name, description) # you're here
  @cookbook.add_recipe(recipe)
end
```

On va donc voir dans la classe *Recipe* ce que fait la méthode *initialize*. Celle-ci se contente de mettre les bonnes valeurs *name* et *description* à l'instance créée.

```ruby
def initialize(name, description)
  @name = name
  @description = description
end
```

On retourne dans la méthode d'où l'on venait, c'est-à-dire la méthode *create* du *controller* pour voir ce qui se passe après... La méthode *add_recipe* du modèle est appelée avec la variable `recipe` (donc l'objet *recipe* qu'on vient de créer) en argument.

```ruby
def create
  name = @view.ask_recipe_name
  description = @view.ask_recipe_description
  recipe = Recipe.new(name, description)
  @cookbook.add_recipe(recipe) # you're here
end
```

On va donc voir dans le *model*. La méthode *add_recipe* ajoute la valeur passée en argument (donc l'objet *recipe* qu'on vient de créer) dans le tableau des recettes. Elle appelle ensuite la méthode *export_csv* qui se trouve dans la même classe.

```ruby
def add_recipe(recipe)
  @recipes << recipe
  export_csv
end
```

On va donc voir ce que fait cette méthode. Celle-ci met à jour le fichier CSV à partir du tableau des recettes, qui intègre désormais notre recette nouvellement ajoutée.

```ruby
def export_csv
  csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
  CSV.open(@csv, 'wb', csv_options) do |csv|
    @recipes.each do |recipe|
      csv << [recipe.name, recipe.description]
    end
  end
end
```
On retourne dans la méthode d'où l'on venait, c'est-à-dire la méthode *create* du *controller* pour voir ce qui se passe après... rien, la méthode est finie (`end`).

```ruby
def list
  recipes = @cookbook.all
  @view.display(recipes)
end # you're here
```

Comme précédemment, on revient dans la boucle du *router* et l'utilisateur peut choisir une nouvelle option.

```
Chemin complet : router => controller => view => controller => view => controller => class Recipe => controller => model => model => CSV => model => controller => router
```


### Suppression d'une recette

Si l'utilisateur choisit 3, la méthode *destroy* du *controller* est appellée :

```ruby
when 3 then @controller.destroy
  ```

On va donc voir dans le fichier *controller.rb*.

La méthode *destroy* appelle d'abord la méthode *all* de l'instance *cookbook* et stocke le retour dans une variable `recipes`. Comme vu précédemment, cette méthode retourne le tableau des objets recettes.

La méthode fait ensuite appel à la méthode *display* de la *view*. Comme vu précédemment, cette méthode affiche la liste des recettes.

La méthode fait ensuite appel à la méthode *ask_recipe_index* de la *view* et stocke le retour dans une variable `index`..

```ruby
def destroy
  recipes = @cookbook.all
  @view.display(recipes)
  index = @view.ask_recipe_index # you're here
  @cookbook.remove_recipe(index)
end
```

On va donc voir dans la *view*. La méthode *ask_recipe_index* retourne ce qu'a indiqué l'utilisateur, transformé en *integer*, et réduit de 1. Donc si l'utilisateur indique "2" (le retour du *gets.chomp*), on le transforme en *integer* ("2" => 2) puis on réduit de 1 (2 => 1).

```ruby
def ask_recipe_index
  puts "Choisissez une recette en indiquant le numéro"
  gets.chomp.to_i - 1
end
```

On retourne dans la méthode d'où l'on venait, c'est-à-dire la méthode *create* du *controller* pour voir ce qui se passe après... La méthode *remove_recipe* du modèle est appelée avec la variable `index` (donc l'index indiqué par l'utilisateur) en argument.

```ruby
def destroy
  recipes = @cookbook.all
  @view.display(recipes)
  index = @view.ask_recipe_index
  @cookbook.remove_recipe(index) # you're here
end
```

On va voir dans le modèle *cookbook*. La méthode *remove_recipe* supprime la valeur du tableau des recettes à l'index indiqué en argument (donc l'index indiqué par l'utilisateur) puis fait appel à la méthode export_csv. Comme vu précédemment, cette méthode met à jour le fichier CSV.

Comme précédemment, on revient dans la boucle du *router* et l'utilisateur peut choisir une nouvelle option.

```
Chemin complet : router => controller => model => controller => view => controller => model => model => CSV => model => controller => router
```
