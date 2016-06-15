# Entity-Relationship-Diagramm-Erzeuger

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
