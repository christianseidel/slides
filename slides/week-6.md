---
marp: true
theme: nf-theme
paginate: true
title: Java Bootcamp - Template
---

# Woche 6

---

## Wochenübersicht

- **Montag**: Freitagsaufgabe, Docker
- **Dienstag**: Heroku, Continuous Deployment
- **Mittwoch**: Datenbanken, MongoDB, Robo3T
- **Donnerstag**: MongoDB Atlas, Spring Config
- **Freitag**: Freitagsaufgabe

---

# Wo stehen wir eigentlich? 🤔

---

## Webanwendung

![](img/browser-backend-db.png)

---

## Wo stehen wir wirklich? 🤔

---

## Wie bekommen wir denn nun diesen Server online? 🌍 🎉🙌

![](img/webarchitektur-komplex.png)

---

## Aber ich möchte kein Admin werden 🤬 <br/>Geht das nicht einfacher? 🤯

---

## Code entwickeln & verpacken

![](img/packaging.png)

---

## Code entwickeln & verpacken

![](img/packaging-2.png)

---

# Docker

---

# Docker

- Plattform um Apps in definierter Umgebung laufen zu lassen (Container)
- Container wird aus Vorlage erstellt (Image)
- Container wird auf Plattform ausgeführt

![bg right contain](img/docker.png)

---

## Docker-Images

- Blueprint für Container
- besteht aus mehreren Layern
- hub stellt bereits viele Images bereit

![bg right 50% contain](img/docker-layers.png)

---

## Docker-Container

- stellt definierte Laufzeitumgebung bereit
- läuft auf Docker Plattform

![bg right 50% contain](img/docker-container.png)

---

## Docker vs VM

- benötigt wesentlich weniger Ressourcen
- startet schneller
- einfacher zu skalieren

![bg right contain](img/container-vs-vm.png)

---

## run

```shell
docker run --name db -p 37017:27017 -d mongo:latest
```

`docker run` startet einen Container mit einem Image

| option           | description                                     |
| ---------------- | ----------------------------------------------- |
| `--name`         | name of the container                           |
| `-d`             | detached                                        |
| `-p 37017:27017` | mapped container port 27017 auf host port 37017 |

---

## ps

```shell
docker ps
```

listet alle laufenden Container.

```shell
docker ps --all
```

listet alle Container.

---

## start / stop

Startet oder stoppt einen Container.

```shell
docker start 324
```

```shell
docker stop 324
```

---

## rm

```shell
docker rm 324
```

Entfernt den Container mit id 324

```shell
docker image rm some-image
```

Entfernt das Image mit id some-image

---

## images

```shell
docker images
```

listet alle Images

---

## inspect

```shell
docker inspect 1234abc
```

Untersucht die Eigenschaften vom Container 1234abc

```shell
docker image inspect foobar
```

Untersucht die Eigenschaften vom image foobar

---

## Aufgabe: Docker

1. Installiere Docker Desktop auf deinen Mac
2. Starte den super mario retro container https://hub.docker.com/r/pengbai/docker-supermario/
3. Spiele zur Belohnung das erste Level 🥳
4. Stoppe den Container um nicht zu viel Zeit zu verlieren
5. Starte den Container erneut
6. Stoppe den Container
7. Lösche den Container

---

<!-- _class: hsplit -->

## Dockerfile

```yml
FROM openjdk:15

ENV ENVIRONMENT=prod

LABEL MatthiasHiemer="matthias.hiemer@neuefische.de"

ADD backend/target/app.jar app.jar

CMD [ "sh", "-c", "java -jar /app.jar" ]
```

| keyword    | Beschreibung         |
| ---------- | -------------------- |
| FROM       | Base image           |
| ENV        | Environment variable |
| LABEL      | Ersteller und Warter |
| ADD        | Fügt Datei hinzu     |
| RUN        | Führt Befehl aus     |
| CMD        | Startkommando        |

---

## Build image

```shell
docker build .
```

Baut Image aus lokalem Dockerfile. Für einfaches tagging kann `--tag` oder `-t` Option verwendet werden.

---

## Aufgabe: Docker Image bauen

1. Suche dir eine Java Anwendung und schreibe ein entsprechendes Dockerfile
2. Baue das Docker image und starte es mit run

---

# Heroku

---

## Heroku

Hosting Provider.

**Vorteile**

- Vereinfacht Hosting von Anwendungen, also auch ohne große Kenntnisse nutzbar
- Kosten transparent

**Nachteile**

- Funktionalität sehr begrenzt
- Wird nur im kleinen Maßstab genutzt
- Sehr teuer bei mehr Traffic

---

## Heroku

- Heroku erwartet, dass Anwendung auf einem bestimmten Port startet.
- Port wird über environment variable PORT bereitgestellt
- application.properties:
  ```
  server.port=${PORT:8080}
  ```

![bg right contain](img/heroku.png)

---

## Aufgabe: Heroku 1

1. Erzeuge eine neue Spring Boot Anwendung
2. Schreibe einen RestController, den du aufrufen kannst
3. Push den Code auf GitHub
4. Melde dich bei Heroku an
5. Deploy deine Java Anwendung auf Heroku
6. Freue dich, dass die Applikation jetzt im Internet ist

---

## Aufgabe: Heroku 2

1. Installiere die [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli#install-the-heroku-cli)
2. Erzeuge dir über die CLI eine neue App ([Dokumentation](https://devcenter.heroku.com/articles/git))
3. Deploye deine Anwendung per CLI nach Heroku

---

# Datenbanken

---

## Eigenschaften

Datenbanken ermöglichen effizientes **Speichern**, **Abrufen**, **Verwalten** von Daten und Datenintegrität

---

## Typen

Abhängig vom Use Case.

Wichtigste Typen

- SQL
- NoSQL
- Graph Database

---

## SQL

- Structured Query Language (SQL)
- Relational Database
- Strukturierung in Tabellen mit Relationen
- Sehr effiziente Speicherung von Daten
- Datenintegrität
- Oft Probleme mit Skalierung

Beispiele:
MySQL, PostgreSQL, Oracal DB

---

## NoSQL

- Not Only SQL (NoSQL)
- Speichern von Objekten
- Keine Relationen zwischen den Objekten
- Leicht Skalierbar
- Datenintegrität zwischen Objekten muss über Software sichergestellt werden

Beispiele:
MongoDB, DynamoDb, Cassandra

---

## Graph Datenbanken

- Relationen zwischen Objekten
- Daten strukturiert wie Knoten und Kanten
- Leicht skalierbar (Menge von Knoten)
- Häufig Probleme mit großen Knoten

Beispiele:
Neo4J, ArangoDB, Amazon Neptune

---

# MongoDB

---

## Document

- Repräsentiert einen Eintrag
- BSON (Binary JSON) Dokument
- `_id`: Object Id
- `<name>: <field-value>`
- [Document docs](https://docs.mongodb.com/manual/core/document/)

```json
{
  "_id": "test-id",
  "name": "Frank"
}
```

---

## Collection

- Zusammenstellung von Dokumenten
- Abfragen auf Collections
- Definition von Eigenschaften wie Index auf Collection
- [Databases and Collections docs](https://docs.mongodb.com/manual/core/databases-and-collections)

---

## DB

- Zusammenstellung von Collections
- Verbindung läuft über Datenbank
- [Databases and Collections docs](https://docs.mongodb.com/manual/core/databases-and-collections)

---

## MongoDB laufen lassen

```shell
   docker run --name db -p 27017:27017 -d mongo
```

---

## MongoDB Compass

[Download](https://www.mongodb.com/try/download/compass)

Grafikoberfläche für Interaktionen:

- Verbinden
- Erstellen
- Abfragen

---

## MongoDB shell

- Falls die Datenbank in einem Docker Container läuft, mit diesem verbinden:
  ```shell
  docker exec -it <containerName> mongosh
  ```

- Zur gewünschten Datenbank wechseln:
  ```javascript
  use <dbName>
  ```

---

## CRUD: Create

[MongoDB CRUD operations](https://docs.mongodb.com/manual/crud/)

```javascript
db.students.insertOne({
    name: “Frank”
})
```

- Dokument zur Collection hinzufügen
- Erzeugt neue Object Id wenn nicht angegeben

---

## CRUD: Read

```javascript
db.collection.find({ name: { $eq: 'Frank' } }).limit(5)
```

- `find` gibt Liste zurück
- über `query` kann Ergebnis eingegrenzt werden
- `limit` setzt maximale Anzahl an zurückgegebenen Dokumenten
- `projection` ermöglicht nur Teile zurückzugeben

---

## CRUD: Update

```javascript
db.students.updateMany({ name: { $eq: 'Frank' } }, { $set: { name: 'Franz' } })
```

- update von ein oder mehreren Dokumenten
- suche über query
- update über `$set`

---

## CRUD: Delete

```javascript
db.students.deleteOne({ name: { $eq: 'Frank' } })
```

- Löschen von Dokumenten auf Basis einer Query
- Löschen von einzelnen oder mehreren Dokumenten möglich

---

## Aufgabe: MongoDB

1. Lade dir MongoDB Compass herunter
2. Lasse ein Docker-Image mit mongodb laufen
3. Erstelle eine DB **devQuiz** und eine Collection **questions**
4. Füge ein Dokument über MongoDB Compass und ein Dokument über die CLI hinzu
5. Ändere die Frage einer `Question`, indem du einmal MongoDB Compass und einmal die CLI verwendest
6. Lösche eine `Question` aus der Datenbank
7. Füge mindestens 5 `Questions` hinzu und stelle eine Abfrage die nach einer `Question` filtert

---

# Previously on Java

- Klassen, Attribute, Methoden, Instanzen/Objekte
- Interfaces für Abstraktion
- Maven als Build-Management-Tool
- Spring, Spring Boot und Dependency Injection

---

# Spring Data

---

## Repository

- Ermöglicht CRUD Operationen
- grundlegende Funktionalität bereits vorhanden
- Automatisches parsen von Daten: Object Relational Model (ORM)

---

## Maven dependency

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-mongodb</artifactId>
</dependency>
```

---

## MongoDB Repository

```java
public interface TodoRepository extends PagingAndSortingRepository<Todo, String> {}
```

- Interface wird durch Spring implementiert und bereitgestellt
- grundlegende Funktionalität vorhanden
- Durch Keywords im Methodennamen können Queries definiert werden

[MongoDb repository docs](https://docs.spring.io/spring-data/mongodb/docs/1.2.0.RELEASE/reference/html/mongo.repositories.html)

[MongoDb queries](https://www.baeldung.com/queries-in-spring-data-mongodb)

---

## Verbindung zur Datenbank

- Über Konfigurationen in der application.properties

```
spring.data.mongodb.database=todo
spring.data.mongodb.host=localhost
spring.data.mongodb.port=27017
```

---

## Aufgabe: Mongo Data

- Erstellt euch ein Spring Boot Projekt mit Spring Web und Spring Data Mongo als dependencies (oder nehmt das von gestern und fügt die Spring Data dependency manuell hinzu)
- Implementiert euch Controller und Service so, dass
  - ihr eine Question Objekt in der Datenbank speichern
  - und wieder auslesen könnt

---

## MongoDB Test

- Embedded MongoDB für Tests
- Wenn Repository im Test Context
  - Datenbank wird vor Test hochgefahren
  - Nach Test runtergefahren
- Damit flapdoodle hochfährt, muss ein Property `src/test/resources/application.properties` gesetzt werden: spring.mongodb.embedded.version=3.0.0

```xml
<dependency>
   <groupId>de.flapdoodle.embed</groupId>
   <artifactId>de.flapdoodle.embed.mongo</artifactId>
   <scope>test</scope>
</dependency>
```

---

## Aufgabe: Integrationstest mit Datenbank

- Bindet flapdoodle als Test-Dependency ein
- Schreibt einen Integrationstest, der über das `TestRestTemplate` eine `Question` anlegt und wieder ausgibt

---

# Alles auf einmal lokal starten

---

<!-- _class: hsplit-->

## Docker Compose

- Mehrere Container orchestriert laufen lassen
- `docker-compose up -d` startet alle container
  - Falls die images neu gebaut werden sollen, ist noch ein `--build` nötig
- `docker-compose down` fährt alles wieder runter

```yml
version: '2'
services:
    db:
        image: mongo:latest
        expose:
            - 27017
        ports:
            - 27017:27017
        restart: unless-stopped
        
    app:
        build: .
        depends_on:
            - db
        expose:
            - 8080
        ports:
            - 8080:8080
        environment:
            - DATABASE_NAME=<dbName>
            - DATABASE_HOST=db
            - DATABASE_PORT=27017
        restart: unless-stopped
```

---

## Umgebungsspezifische properties

- `application-docker.properties`
```
spring.data.mongodb.database=${DATABASE_NAME}
spring.data.mongodb.host=${DATABASE_HOST}
spring.data.mongodb.port=${DATABASE_PORT}
```

---

## Aufgabe: Docker Compose

Erstellt ein `docker-compose`-file für eure Anwendung von gestern.

---

# Spring Configuration

---

## application.properties

- Setzt Konfigurationen
- Kann während der Laufzeit benutzt werden

```
spring.data.mongodb.database=todo
spring.data.mongodb.host=localhost
spring.data.mongodb.port=27017
```

---

## application.yml

Wie `application.properties` nur im yml Format.

```yml
spring.data.mongodb:
  database: todo
  host: localhost
  port: 27017
```

---

## conf value

Liest einen Wert aus der Konfiguration.

```java
@Value("{spring.data.mongodb.host}")
public String mongoHost;
```

---

## conf class

- Konfiguration von mehreren Werten
- `@EnableConfigurationProperties` muss gesetzt sein

```java
@Configuration
@Data
@ConfigurationProperties(prefix = "spring.data.mongodb")
public class SomeConfiguration {

 private String host;
 private int port;
}


@EnableConfigurationProperties(SomeConfiguration.class)
```

---

## Environment

- Environment Variable überschreibt property
- ermöglichen Konfiguration beim Start
- Konfiguration möglich ohne Code zu ändern

---

## Aufgabe: Konfiguration

1. Konfiguriere deinen Serverport über eine application.yml
2. Konfiguriere deinen Serverport über eine Environment variable
3. Ändere dein Dashboard code, sodass die api url über das environment gesetzt werden kann

---

# Mongo und Heroku

---

## Wo hosten wir unsere MongoDB

- [mongodb altas](https://www.mongodb.com)
- hosten von mongo cluster
- kostenlos bis zu einem gewissen Kontingent

---

## Konfiguration

![bg right contain 75%](img/mongo-atlas.png)

```
mongodb+srv://user:password@clusterurl/db
```

`MONGODB_URI` muss in heroku konfiguriert werden und über docker an die app gegeben werden.

Erlauben in mongoDb atlas das heroku eine verbindung aufbauen kann.

---

## Aufgabe: MongoDB Atlas

1. Erstelle dir einen MongoDb atlas account
2. Lege einen MongoDb cluster an
3. Erlaube heroku auf deine mongoDb zuzugreifen
4. Konfiguriere die MongoDB uri und deploye deine application

---

# Freitagsaufgabe

- Baue Spring Data in die TodoApp ein, so dass die TODOs in einer richtigen Datenbank gespeichert werden.
- Da keine neue Logik hinzukommt, müssen keine neuen Tests geschrieben werden. Die bestehenden sollen aber noch funktionieren.
  - Mocke in Unit Tests das Repository
  - Benutze flapdoodle, damit die Intgrationstests weiterhin laufen.
  - Du hast noch keine Tests in der TodoApp? Dann wird es aber Zeit.
- Bringe deine TodoApp auf Heroku und verknüpfe sie mit Atlas.
  - **Hinweis 1:** Denk an die `.production.env`-Datei im Frontend
  - **Hinweis 2:** Pass denn Dateinamen in der `Procfile`-Datei an

---

# React Routing fix

---

## Spring web server

![](img/request-mapping.png)

---

## Forward to index.html

```java
@Controller
public class ReactRoutingForwarding {

    @RequestMapping(value = "/**/{[path:[^\\.]*}")
    public String forwardToRoutUrl() {
        return "forward:/";
    }
}
```

- matching path wird abgefangen, wenn durch Restcontroller dieser durch den Controller nicht bedient wird
- request wird weitergeleitet
- durch forward wird Route nicht verändert
- In `src/main/resources`: `spring.mvc.pathmatch.matching-strategy=ant_path_matcher`
