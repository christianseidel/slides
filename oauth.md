---
marp: true
theme: nf-theme
paginate: true
title: Java Bootcamp - OAuth
---

# OAuth

[https://oauth.net/2/](https://oauth.net/2/)

![bg right 75%](img/oauth_logo.png)

---

## Motivation

Nutzer wollen Apps erlauben die Daten anderer Apps zu nutzen, ohne ihre Login Information presigeben zu müssen.

### Beispiele

Apps können..

- Daten in Google drive / Dropbox ablegen
- Nachrichten auf Twitter posten
- Login mit GitHub (Pseudo-Auth)

---

## OAuth Protocol Flow

1. **Authorization Request**
   Nutzer muss Zugriff erlauben
2. **Authorization Grant**
   Access token wird ausgestellt
3. **Access**
   Request mit dem token sind authorisiert

---

[RFC 6749 - The OAuth 2.0 Authorization Framework](https://datatracker.ietf.org/doc/html/rfc6749)

```
     +--------+                               +---------------+
     |        |--(A)- Authorization Request ->|   Resource    |
     |        |                               |     Owner     |
     |        |<-(B)-- Authorization Grant ---|               |
     |        |                               +---------------+
     |        |
     |        |                               +---------------+
     |        |--(C)-- Authorization Grant -->| Authorization |
     | Client |                               |     Server    |
     |        |<-(D)----- Access Token -------|               |
     |        |                               +---------------+
     |        |
     |        |                               +---------------+
     |        |--(E)----- Access Token ------>|    Resource   |
     |        |                               |     Server    |
     |        |<-(F)--- Protected Resource ---|               |
     +--------+                               +---------------+
```

---

## GitHub OAuth Apps

1. [Neue OAuth App registrieren](https://docs.github.com/en/developers/apps/building-oauth-apps/creating-an-oauth-app)
2. [Authorisierung](https://docs.github.com/en/developers/apps/building-oauth-apps/authorizing-oauth-apps)

---

## Demo

---

# Login mit GitHub

---

## Pseudo-Auth

Der Nutzer muss sich authentifizieren um uns authorisieren zu können.

Die API liefert uns einen Endpunkt um die Identität des gerade eingelogten Nutzers festzustellen.

Wenn ein Nutzer sich per GitHub authentifiziert hat und sein Profil zu einem Nutzer unserer App passt ist er authorisiert.

---

## Endpunkt

`POST /auth/oauth/github/access_token`

### Flow

1. Access token bekommen
2. Userprofil mit Access token abfragen
3. Validieren ob App-Nutzer (falls nötig)
4. JWT erstellen
