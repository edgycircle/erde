# Entity-Relationship-Diagramm-Erzeuger
A simple tool to generate Entity-Relationship-Diagrams based on text input or directly from a PostgreSQL database. The format of the text schema is inspired and based on ["erd" by Andrew Gallant](https://github.com/BurntSushi/erd).

## CLI Usage
~~~txt
bin/erde file docs/schema.txt docs/schema.png
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
