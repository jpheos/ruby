# Formats

Il existe trois formats pour le parsing et le storing.

**Le format CSV**

Par défaut, les valeurs sont séparées par des `,` et englobées dans des `""`, mais cela peut différer d'un fichier CSV à l'autre. Par exemple, certains CSV séparent les valeurs avec des `;`, affichent les valeurs sans guillements et n'ont pas de *header* (ligne titrant les colonnes en première ligne).

```csv
"Firstname", "Lastname", "Age"
"John", "Doe", "30"
"Jane", "Did", "33"
```

**Le format XML**

Le format XML, très proche du HTML, tend à disparaître.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<contacts>
  <title>My contacts</title>
  <contact>
    <firstname>John</firstname>
    <lastname>Doe</lastname>
    <age>30</age>
  </contact>
  <contact>
    <firstname>Jane</firstname>
    <lastname>Did</lastname>
    <age>33</age>
  </contact>
</contacts>
```

**Le format JSON**

Le format JSON est le plus utilisé. Il peut être constitué d'un *hash* `{}` ou d'un *array*.

```json
{
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
```


# Parsing et storing

Le *parsing* consiste à récupérer des données au format CSV, XML ou JSON et à les décrypter pour les rendre utilisables par le langage (Ruby ou autre). Typiquement, il s'agira de les transformer en *array* ou *hash*. Les données passent d'un format dit **sérialisé** (*string*) à un format **désérialisé** (*array*, *hash*).

Le *storing* est l'opposé du *parsing*. Les données sont sérialisées pour être conservées sur un disque dur au format CSV, XML ou JSON.

# CSV

Le module `csv` est importé avec `require`.

**Parsing**
Les options sont définies : `col_sep` pour la séparation des colonnes, `quote_char` pour l'encadrement des valeurs, `headers` pour l'entête.
La méthode `CSV.foreach` crée une boucle permettant d'effectuer une action ligne par ligne, chaque ligne étant un tableau de colonnes.

**Storing**
Les options sont définies : `col_sep` pour la séparation des colonnes, `force_quotes` pour la présence d'encadrement et `quote_char` pour le signe d'encadrement. La méthode `CSV.open` prend trois arguments. Le deuxième signifie le mode d'ouverture : `r` pour *read* (défaut), `w` pour *write*, `a` pour *append* (à la suite), le `b` suivant signifiant que la donnée est directement écrite sur le disque dur.

```ruby
require 'csv'
filepath = 'contacts.csv'

# Parsing

csv_options = { col_sep: ',', quote_char: '"', headers: first_row }
CSV.foreach(filepath, csv_options) do |row|
  row.each { |value| p value }
end

# Storing

csv_optionss = { col_sep: ',', force_quotes: true, quote_char: '"' }
CSV.open(filepath, 'wb', csv_options) do |csv|
  csv << ["Firstname", "Lastname", "Age"]
  csv << ["John", "Doe", "30"]
  csv << ["Jane", "Did", "33"]
end
```


# JSON

Le module `json` est importé avec `require`.

**Parsing**
Le fichier est récupéré au format sérialisé (*string*) avec `File.read(path)` puis est désérialisé (en *hash* ou *array*) avec la méthode `JSON.parse`.

**Storing**
Le fichier réceptionnant les données est ouvert avec la méthode `File.open` (les options types `wb` étant les mêmes qu'en CSV) puis reçoit les données avec la méthode `file.write`. Les données sont sérialisées avec la méthode `JSON.generate` qui peut être passée directement en attribut de la méthode précédente.

```ruby
require 'json'
filepath = 'contacts.json'

# Parsing

serialized_contacts = File.read(filepath)
contacts = JSON.parse(serialized_contacts)

# Storing

contacts = {
  contacts: [
    { firstname: 'John', lastname: 'Doe', age: 30 },
    { firstname: 'Jane', lastname: 'Did', age: 33 }
]}
File.open(filepath, 'wb') do |file|
  file.write(JSON.generate(contacts))
end
```

Pour récupérer des éléments à partir d'une web API, il faut adapter le code :

```ruby
require 'json'
require 'open-uri'
url = 'https://api.github.com/users/BigBigDoudou'
user_serialized = open(url).read
user = JSON.parse(user_serialized)
```

Le module `open-uri` est nécessaire pour ouvrir des adresses HTTP. Comme pour un fichier local, les données sont lues (format sérialisé) puis transformées avec la méthode `JSON.parse`.


# XML

La gem *nokogiri* doit être installée en amont. Le module `nokogiri` est importé avec `require`.

**Parsing**
Le fichier est récupéré au format sérialisé puis *nokogiri* est utilisée pour transformer le fichier en document lisible par Ruby. La méthode `root.xpath` est utilisée en boucle sur chaque élément (ici "*contact*") pour récupérer et traiter les données.

**Storing**
Le format est créé grâce au *builder* fourni par *nokogiri*. Il est ensuite intégré dans le fichier avec la méthode `File.open`.

```ruby
require 'nokogiri'

# Parsing

file     = File.open('contacts.xml')
document = Nokogiri::XML(file)
document.root.xpath('contact').each do |contact|
  firstname = contact.xpath('firstname').text
  lastname  = contact.xpath('lastname').text
  age       = contact.xpath('age').text
end

# Storing

filepath = 'contacts.xml'
builder   = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do
  contacts do
    contact do
      firstname 'John'
      lastname  'Doe'
      age       '30'
    end
    contact do
      firstname 'Jane'
      lastname  'Did'
      age       '33'
    end
  end
end
File.open(filepath, 'wb') { |file| file.write(builder.to_xml) }
```
