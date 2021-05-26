---
marp: true
theme: nf-theme
paginate: true
title: Java Bootcamp - Template
---

# Woche 6

---

## Wochenübersicht

- **Montag**: Feiertag
- **Dienstag**: Freitagsaufgabe, Team-Projekt start
- **Mittwoch**: Container Technology, Docker, App in Docker, Spring Config, Heroku, Continuous Deployment
- **Donnerstag**: Datenbanken Intro, Mongo Intro, Careere Session
- **Freitag**: Mongo mit Spring, Spring config Mongo, Deploy Heroku mit Mongo

---

# Team Projekt: GitHub Roulette

**User stories**

- Als Nutzer möchte ich meinen PR einstellen können
- Als Nutzer möchte ich alle offenen PRs sehen
- Als Nutzer möchte ich mir einen PR zuweisen lassen können
- Als Nutzer möchte ich einen PR als “on review” markieren können
- Als Nutzer möchte ich das closed PRs nicht mehr angezeigt werden
- Als Nutzer möchte ich mein Review Karma sehen (reviewed vs eingestellt)

---

## Team Projekt: First Steps

Projekt aufsetzen

- Kanban erstellen
- Backend initialisieren
- Frontend initialisieren
- Deployment

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

- benötigt wesentlich weniger ressourcen
- startet schneller
- einfacher zu skalieren

![bg right contain](img/docker-vs-vms.png)

---

## run

```shell
docker run --name some-mongo -p 37017:27017 -d mongo:tag
```

docker `run` startet einen Container mit einem Image

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

Startet oder Stoppt einen Container.

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

Entfernt den container mit id 324

```shell
docker image rm some-image
```

Entfernt das image mit id some-image

---

## images

```shell
docker mages
```

listet alle images

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

MAINTAINER Fabian Schmauder <fabian.schmauder@gmail.com>

ADD backend/target/app.jar app.jar

CMD [ "sh", "-c", "java -jar /app.jar" ]
```

| keyword    | Beschreibung         |
| ---------- | -------------------- |
| FROM       | Base image           |
| ENV        | Environment variable |
| MAINTAINER | Ersteller und Warter |
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

- Vereinfacht Hosting von Anwendungen auch ohne Große Kenntnis nutzbar
- Kosten transparent

**Nachteile**

- Funktionalität sehr begrenzt
- Wird nur im kleinen Maßstab genutzt
- Sehr teuer bei mehr Traffic

---

## Heroku

- Heroku erwartet das Anwendung auf einem bestimmten Port startet.
- Port wird über environment variable PORT bereitgestellt
- Docker file:
  ```
  -Dserver.port=$PORT
  ```
- `heroku.yml` spezifiziert docker environment

![bg right contain](img/heroku.png)

---

## Aufgabe: Heroku

1. Melde dich bei Heroku an
2. Installiere dir die CLI
3. Lese dir die Heroku docker Getting started durch
4. Deploy deine Java Anwendung

---

# CD Pipeline

---

## Motivation

- Deployment should be easy
- Automation prevents errors

---

## Github Action

Führe bei einem push ein deployment aus.

```yml
on:
 push:
   branches: [ master ]

- name: Login to Heroku Container registry
 env:
   HEROKU_API_KEY: ${{ secrets.HEROKU_API_KEY }}
 run: heroku container:login
- name: Build and push
 env:
   HEROKU_API_KEY: ${{ secrets.HEROKU_API_KEY }}
 run: heroku container:push -a nf-todo-app web
- name: Release
 env:
   HEROKU_API_KEY: ${{ secrets.HEROKU_API_KEY }}
 run: heroku container:release -a nf-todo-app web

```

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
- Daten Strukturiert wie Knoten und Kanten
- Leicht Skalierbar (Menge von Knoten)
- Häufig Probleme mit Großen Knoten

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
    "_id" : "test-id",
    "name" : "Frank",
    "matrikelnummer" : NumberLong(3)
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

## Robo 3T

Grafikoberfläche für Interaktionen:

- Verbinden
- Erstellen
- Abfragen

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
db.collection.find({ name: { $eq: "Frank" } }).limit(5);
```

- find gibt Liste zurück
- über `query` kann Ergebnis eingegrenzt werden
- `limit` setzt maximale Anzahl an zurückgegebenen Dokumenten
- `projection` ermöglicht nur Teile zurück zu geben

---

## CRUD: Update

```javascript
db.students.updateMany({ name: { $eq: "Frank" } }, { $set: { name: "Franz" } });
```

- update von ein oder mehreren Dokumenten
- suche über query
- update über `$set`

---

## CRUD: Delete

```javascript
db.students.deleteOne({ name: { $eq: "Frank" } });
```

- Löschen von Dokumenten auf Basis einer Query
- Löschen von einzelnen oder mehreren Dokumenten möglich

---

## Aufgabe: MongoDB

1. Installiere MongoDB Doc und Robo 3T
2. Erstelle eine DB githubRoulette und Collection repos
3. Füge ein Dokument über Robo 3T und ein Dokument über die cli hinzu
4. Ändere den Namen eines Repos, indem du einmal Robo 3T und einmal die cli verwendest
5. lösche ein Repo aus der Datenbank
6. Füge mindestens 5 Repos hinzu mit verschiedenen ownern und stelle eine Abfrage die nach einem owner filtert

---

# Spring Data

---

## Repository

- Ermöglicht CRUD Operationen
- grundlegende Funktionalität bereits vorhanden
- Automatisches parsen von Daten: Object Relational Model (ORM)

---

## MongoDB Repository

```java
public interface TodoRepository extends PagingAndSortingRepository<TodoItem, String> {}
```

- Interface wird durch Spring implementiert und bereitgestellt
- grundlegende Funktionalität vorhanden
- Durch Keywords im Methodennamen können Queries definiert werden

[MongoDb repository docs](https://docs.spring.io/spring-data/mongodb/docs/1.2.0.RELEASE/reference/html/mongo.repositories.html)

[MongoDb queries](https://www.baeldung.com/queries-in-spring-data-mongodb)

---

## Aufgabe: Mongo Data

Füge zum Projekt ein Repository hinzu, welches repos

- in die MongoDB speichert
- aus der DB abfragt

---

## MongoDB Test

- Embedded MongoDB für Tests
- Wenn Repository im Test Context
  - Datenbank wird vor Test hochgefahren
  - Nach Test runtergefahren

```xml
<dependency>
   <groupId>de.flapdoodle.embed</groupId>
   <artifactId>de.flapdoodle.embed.mongo</artifactId>
   <scope>test</scope>
</dependency>
```

---

## Aufgabe: Repository Test

- Schreibe Integration Tests welche repos in die Datenbank speichern
- Schreibe Integration Tests welche repos aus der Datenbank holt

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

Ließt einen Wert aus der Konfiguration.

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

1. Konfiguriere deinen Server Port über eine application.yml
2. Konfiguriere deinen Server Port über eine Environment variable
3. Ändere dein Dashboard code, sodass die api url über das environment gesetzt werden kann

---

# Mongo und Heroku

---

## Wo hosten wir unsere MongoDB

- [mongodb altas](https://www.mongodb.com)
- hosten von mongo cluster
- kostenlos bis zu einem gewissen kontingent

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

- matching path wird abgefangen wenn durch restcontroller dieser durch controller nicht bedient wird
- request wird weiter geleitet
- durch forward wird route nicht verändert
