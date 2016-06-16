# Entity-Relationship-Diagramm-Erzeuger
A simple tool to generate Entity-Relationship-Diagrams based on text input or directly from a PostgreSQL database. The format of the text schema is inspired and based on ["erd" by Andrew Gallant](https://github.com/BurntSushi/erd).

## Install
Make sure you have [Graphviz](http://graphviz.org/) installed and available in your `$PATH`.  Install the gem with `gem install erde` or add it to your `Gemfile`.

## CLI Usage
~~~txt
bin/erde file docs/schema.txt docs/schema.png
~~~

~~~txt
bin/erde database postgres://user:password@localhost/your_database docs/schema.png
~~~

## Text Schema Format
~~~txt
[identities]
id
password
email

[players]
id
name
identity_id

players:identity_id -- identities:id
~~~
