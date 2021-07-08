---
marp: true
theme: nf-theme
paginate: true
title: Java Bootcamp - Template
---

# 🎉🎉🎉 Happy Birthday Michael 🎉🎉🎉

---

# Woche 7

---

## Wochenübersicht

- **Montag**: MongoDB Atlas, Streams, Enums, Generics, Swagger
- **Dienstag**: Spring boot security, security configuration, basic auth
- **Mittwoch**: JWT, login, protected routes, context API
- **Donnerstag**: OAuth, Login with GitHub
- **Freitag**: GithubRoulette

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

`MONGODB_URI` muss in heroku konfiguriert werden und über docker an die App gegeben werden.

In mongoDb atlas muss heroku erlaubt werden eine Verbindung aufzubauen.

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

- matching path wird abgefangen, wenn durch Restcontroller dieser durch den Controller nicht bedient wird
- request wird weitergeleitet
- durch forward wird Route nicht verändert

---

# Wo stehen wir? 🤔

---

## Webanwendung

![](img/wo-stehen-wir-6.png)

---

# MongoDB query

---

## MongoDB Repository

- find by … Greater than …
- keywords mappen auf Query
- [Docs](https://docs.spring.io/spring-data/mongodb/docs/1.2.0.RELEASE/reference/html/mongo.repositories.html)
- [Query blog artikel](https://www.baeldung.com/queries-in-spring-data-mongodb)

```java
public interface IdeaMongoDb extends PagingAndSortingRepository<Idea,String>{

    List<Idea> findByStarsGreaterThan(int stars);

}
```

---

## MongoDB Repository

- Definition eigener query und Rückgabefelder
- Placeholder werden durch Methodenparameter ersetzt

```java
public interface IdeaMongoDb extends PagingAndSortingRepository<Idea,String> {

 @Query(value="{ 'user' : ?0 }", fields="{ 'user' : 1, 'description' : 1}")
 List<Idea> otherQuery(String userValue);

}
```

---

## Mongo Template

- wenn standard queries nicht ausreichen
- ermöglicht komplexe Abfragen
- ermöglicht Updates
- ermöglicht Aggregationen
- kann injected werden

[Tutorial](https://www.baeldung.com/spring-data-mongodb-tutorial)

```java
Update update = new Update();
update.set("description", "fancy");

template.updateFirst(
Query.query(Criteria.where("user").is("test")), update, Idea.class);
```

---

## Aufgabe: MongoDB 2.0

1. Füge zur PullRequest Klasse ein int Feld “watchedBy” hinzu
2. Schreibe eine Methode welche dir alle Pull Requests zurückgibt, die von x gewatched wurden

---

# Java Streams

---

## Übersicht

- Seit Java 1.8
- Operationen auf Iterable
- Functional Programming (FP) Ansatz

```java
list.stream().filter(element -> element.contains("sub"));
```

---

## Stream Methods

`forEach`, `map`, `collect`, `filter`, `findFirst`, `peek`, `sorted`, `min`, `max`, `distinct`, and _many_ more, see [Stream API](https://docs.oracle.com/en/java/javase/15/docs/api/java.base/java/util/stream/Stream.html)

---

## Aufgabe: Streams

Clone das Repo [streams-exercises](https://github.com/christophersiem/streams-exercises) und löse die Aufgaben in der Klasse StudentService

---

# Enums

---

<!-- _class: hsplit-->

## Enum

- feste Anzahl von Ausprägungen
- häufig mit switch oder if/else
- Ausprägungen können Member und Methoden haben
- Konstruktor ist nicht public

```Java
public enum Directions {
   NORTH("N"),
   EAST("E"),
   SOUTH("S"),
   WEST("W");

   public final String abbreviation;

   Directions(String abbreviation){
       this.abbreviation = abbreviation;
   }
}
```

---

## Aufgabe: Enums

1. Ersetze im [streams-exercises Repository](https://github.com/christophersiem/streams-exercises) im Student & StudentDto model den Typ der location durch ein Enum und passe den restlichen Code entsprechend an.
2. Erweitere das Enum um eine Membervariable `int population`

---

# Generics

---

## Generic function

- Ermöglicht Methode für unterschiedliche Objekte zu schreiben
- Angabe durch Typparameter `<T>`
- Buchstabe frei wählbar, best practice: T,U,V..
- `T extends Student` => T muss Interface oder Klasse Student implementieren

```Java
private <T> T someGenericFunction(T value){
 // some code
 return value;
}

private <T extends Student> T someGenericFunction(T value){
```

---

## Generic Class/Interface

Ermöglicht Klassen für mehrere Objekte zu definieren.

```Java
public class HashMap<K,V>
```

---

## Aufgabe: Generics

1. Schaue dir die ArrayList Klasse an und versuche nachzuvollziehen wie Generics verwendet werden
2. Erstelle eine generische Klasse und rufe sie auf

---

# Swagger

---

## Swagger client

- Swagger gibt Übersicht über Endpunkte
- [https://swagger.io/tools/swagger-ui/](https://swagger.io/tools/swagger-ui/)
- Ausführung ähnlich zu Postman

---

<!-- _class: hsplit-->

## Swagger Setup

<div>

- Maven dependency
- Config
- [http://localhost:8080/swagger-ui.html](http://localhost:8080/swagger-ui.html)

```xml
<dependency>
   <groupId>io.springfox</groupId>
   <artifactId>springfox-swagger2</artifactId>
   <version>2.9.2</version>
</dependency>
<dependency>
   <groupId>io.springfox</groupId>
   <artifactId>springfox-swagger-ui</artifactId>
   <version>2.9.2</version>
</dependency>
```

</div>

```java
@Configuration
@EnableSwagger2
public class SwaggerConfig {

 @Bean
 public Docket api(){
 return new Docket(DocumentationType.SWAGGER_2)
     .select()
     .apis(RequestHandlerSelectors.any())
     .paths(PathSelectors.any())
     .build();
 }
}
```

---

## Aufgabe: Swagger

1. Binde Swagger in unser Gruppenprojekt ein und rufe die Endpunkte auf

---

# Spring boot security

---

## Einbinden

```xml
<dependency>
   <groupId>org.springframework.boot</groupId>
   <artifactId>spring-boot-starter-security</artifactId>
</dependency>
```

- Dependency reicht um Endpunkte abzusichern.
- [Docs](https://docs.spring.io/spring-security/site/docs/5.4.0-M1/reference/html5/)
- [Video Tutorial](https://www.youtube.com/watch?v=sm-8qfMWEV8&list=PLqq-6Pq4lTTYTEooakHchTGglSvkZAjnE)

> user:user
> passwort: siehe logs

---

## User config

- setzen von user und passwort
- passwort **nicht** fest setzen und in git hochladen
- auch über `env` möglich

```yml
spring:
  security:
    user:
      name: admin
      password: 123456
```

---

## Aufgabe: Spring Security 1

1. Füge zu deiner Anwendung spring security hinzu
2. logge dich über die Oberfläche ein

---

# Spring Security Config

---

![bg bottom contain 50%](img/request-filter.png)

---

## Configure user

```java
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
    auth.inMemoryAuthentication()
        .withUser("frank")
        .password("frank1").roles("ADMIN");
    }

    @Bean
    public PasswordEncoder passwordEncoder(){
        return NoOpPasswordEncoder.getInstance();
    }

}
```

---

## Configure http

- authenticate or permit
- formLogin to show login form

```java
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    // more config..

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disabled().authorizeRequests()
            .antMatchers("/**").authenticated()
            .and().formLogin()
            .and().httpBasic();
    }

}
```

---

## Aufgabe: Spring Security 2

1. Fügt eine SecurityConfig hinzu
2. Setzt den passwort encoder
3. Konfiguriert die abgesicherten Endpunkte

---

# Spring Security mongodb

---

## Config

UserDetailsService muss konfiguriert werden.

```java
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    // more config...

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService);
    }
}
```

---

## UserDetailsService

- implement Spring Interface
- load user by name
- return Spring User

```java
@Component
public class MongoUserDetailsService implements UserDetailsService {

    private final UserRepository repository;

    @Autowired
    public MongoUserDetailsService(UserRepository repository) {
        this.repository = repository;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserMongo user = repository.findByUsername(username);
        if(user == null) {
            throw new UsernameNotFoundException("User not found");
        }
        return new User(user.getUsername(), user.getPassword(), List.of(new SimpleGrantedAuthority("user")));
    }
}
```

---

## Aufgabe: Spring Security 3

Nutzt einen UserDetailsService, der die User aus der Datenbank lädt.

---

## Passwörter hashen

- von Hash kann nicht auf Passwort geschlossen werden
- Hashwerte werden verglichen
- bei Datenpanne sind Passwörter nicht lesbar

```java
@Bean
public PasswordEncoder passwordEncoder() {
 return new BCryptPasswordEncoder();
}
```

---

## Principal

- beinhaltet den gerade eingeloggten User
- kann vom SecurityContextHolder abgefragt werden:
  `java SecurityContextHolder.getContext().getAuthentication() `
- Wird in Controller-Methoden automatisch vom Framework an den entsprechenden Principal Parameter weitergegeben

```java
@GetMapping("me")
public GitHubUser getLoggedInUser(Principal principal){

   String username = principal.getName();

   return userService
           .getUserByUsername(username)
           .orElseThrow();
}
```

---

## Aufgabe: Spring Security 4

- Nutze BCrypt Verschlüsselung um die Passwörter zu hashen
- Füge einen neuen GET Endpunkt /api/user/me hinzu, der den gerade eingeloggten User zurückgibt, ziehe den Namen des Users aus dem Principal.

---

# Woher weiß das Backend eigentlich wer ich bin? 🤔

---

## Session cookie

- JSESSIONID
- wird beim Aufruf gesetzt
- wird bei Requests mitgesendet

```
Cookie: JSESSIONID 1A6A3EBA81C6A738A18D736AA838587A
```

---

## Nachtteile

- Cookies müssen akzeptiert werden
- Wenn Server neu startet ist die Session nicht mehr vorhanden oder muss irgendwo abgelegt werden
- Bei mehreren Servern/Containern/Services muss die Session geteilt werden

---

# Können wir den User nicht eine art Schlüssel geben? 🤔

---

# JWT

---

<!-- _class: hsplit-->

## JSON Web Token

```json
{
 "alg": "HS256",
 "typ": "JWT"
}
{
  "sub": "1234567890",
  "name": "John Doe",
  "iat": 1516239022
}

HMACSHA256(
  base64UrlEncode(header) + "." +
  base64UrlEncode(payload),
  secret
```

```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9
.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI
6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDI
yfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6y
JV_adQssw5c
```

---

![bg contain 70%](img/jwt-flow.png)

---

## JSON Web Token

- Secret darf nicht an User gesendet werden
- Bei mehreren verschiedenen Services legt man meist einen Auth Service an

---

# Spring JWT

---

## Was müssen wir tun?

1. Login endpunkt bauen/erreichbar machen
2. Password validieren
3. Jwt erzeugen und zurück geben
4. Filter erzeugen um request zu validieren

---

## Login controller bauen

- erreichbar unter `auth/login`
- AuthenticationManager kümmert sich um password Validierung
- jwtService Helper für jwt actions

```java

@RestController
@RequestMapping("auth/login")
public class LoginController {

    private final AuthenticationManager authenticationManager;
    private final JWTUtils jwtService;

    @Autowired
    public LoginController(AuthenticationManager authenticationManager, JWTUtils jwtService) {
        this.authenticationManager = authenticationManager;
        this.jwtService = jwtService;
    }

    @PostMapping
    public String login(@RequestBody LoginData data) {
        try {
            authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(data.getName(), data.getPassword()));
            return jwtService.createToken(new HashMap<>(), data.getName());
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "invalid credentials");
        }
    }
}
```

---

## AuthenticationManager

- in Spring verfügbar machen
- Bean notation um inject ausführen zu können
- Config einfügen:
  ```java
  @Override
  @Bean
  public AuthenticationManager authenticationManagerBean() throws Exception {
      return super.authenticationManagerBean();
  }
  ```

---

## JwtUtils

- io.jsonwebtoken: bietet funktion für jwt an
- javax.xml.bind: ermöglicht schneller zu signieren und ist in neuen java version(9+) **nicht standardmäßig** enthalten

```xml
<dependency>
   <groupId>io.jsonwebtoken</groupId>
   <artifactId>jjwt</artifactId>
   <version>0.9.1</version>
</dependency>
<dependency>
   <groupId>javax.xml.bind</groupId>
   <artifactId>jaxb-api</artifactId>
   <version>2.3.1</version>
</dependency>
```

---

## JWT erzeugen

- erzeugen von jwt token
- 4 Stunden valide
- Festlegen von Algorithmus

```java
@Service
public class JWTUtils {

    private String secret = "secret-token";

    public String createToken(Map<String, Object> claims, String subject) {
        return Jwts.builder()
            .setClaims(claims)
            .setSubject(subject)
            .setIssuedAt(Date.from(Instant.now()))
            .setExpiration(Date.from(Instant.now().plus(Duration.ofHours(4))))
            .signWith(SignatureAlgorithm.HS256, secret)
            .compact();
    }
}
```

---

## Endpunkt erreichbar machen

Alle Endpunkte außer api frei zugänglich.

```java
@Override
protected void configure(HttpSecurity http) throws Exception {
    http
        .authorizeRequests()
        .antMatchers("/api/**").authenticated()
        .antMatchers("/**").permitAll();
}
```

---

## Revmove session state

- Session state mit JWT nicht mehr nötig
- in config updaten

```java
@Override
protected void configure(HttpSecurity http) throws Exception {
    // more config..
    .and().sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);
}
```

---

## Filter hinzufügen

- wird bei jedem Request ausgeführt
- setzt wenn vorhanden Security Context
- auf Basis des Context kann Spring entscheiden ob Berechtigung vorliegt

---

## Filter hinzufügen

```java
@Component
public class JwtAuthFilter extends OncePerRequestFilter {

    private final JWTUtils jwtUtils;
    private final MongoUserDetailsService service;

    @Autowired
    public JwtAuthFilter(JWTUtils jwtUtils, MongoUserDetailsService service) {
        this.jwtUtils = jwtUtils;
        this.service = service;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, FilterChain filterChain) throws ServletException, IOException {
        String token = getToken(httpServletRequest);
        String userName = token != null ? jwtUtils.extractUserName(token) : null;
        if (userName != null && SecurityContextHolder.getContext().getAuthentication() == null) {

            UserDetails userDetails = service.loadUserByUsername(userName);

            if (jwtUtils.validateToken(token, userDetails.getUsername())) {

                UsernamePasswordAuthenticationToken token =
               new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities();

                token
                .setDetails(new WebAuthenticationDetailsSource().
                buildDetails(httpServletRequest));
                SecurityContextHolder.getContext().setAuthentication(token);
        }
   }
   filterChain.doFilter(httpServletRequest, httpServletResponse);
 }

 private String getToken(HttpServletRequest httpServletRequest) {
   String authHeader = httpServletRequest.getHeader("Authorization");
   if (authHeader != null) {
     return authHeader.replace("Bearer", "").trim();
   }
   return null;
 }
}
```

---

## jwt Metods

```java

public String extractUserName(String token) {
    Claims claims = extractAllClaims(token);
    return claims.getSubject();
}

private Claims extractAllClaims(String token) {
    return Jwts.parser().setSigningKey(secret).parseClaimsJws(token).getBody();
}

private Boolean isTokenExpired(String token) {
    Claims claims = extractAllClaims(token);
    return claims.getExpiration().before(new Date());
}

public Boolean validateToken(String token, String username) {
    String userName = extractUserName(token);
    return (userName.equals(username) && !isTokenExpired(token));
}
```

---

## Security context

Principal enthält Nutzerdaten

```java

@PutMapping
public Idea addToDo(@RequestBody @Valid AddIdeaDto data, Principal principal) {
```

---
