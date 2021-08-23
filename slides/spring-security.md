---
marp: true
theme: nf-theme
paginate: true
title: Spring Security
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

---

## User config

- passwort **nicht** fest setzen und in git hochladen

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

## Configure authentication

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

## Swagger-UI erreichbar machen

```java
    private final String[] SWAGGER_URLS = {"/v2/api-docs/**","/swagger-ui/**", "/swagger-resources/**"};

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        //..
        .antMatchers(HttpMethod.GET, SWAGGER_URLS).permitAll()
        //..
    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers(HttpMethod.GET,SWAGGER_URLS);
    }
```

---

## Aufgabe: Spring Security 2

1. Fügt eine SecurityConfig hinzu
2. Setzt den `PasswortEncoder`
3. Konfiguriert die abgesicherten Endpunkte

---

# Spring Security mongodb

---

## UserDetailsService Config

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

```java
@Service
public class UserEntityDetailsService implements UserDetailsService {

    private final UserRepository userRepository;

    @Autowired
    public UserEntityDetailsService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public UserEntity loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepository
                .findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("Username not found: "+username));
    }
}

public class UserEntity implements UserDetails {/*...*/}
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
- `SecurityContextHolder.getContext().getAuthentication()`
- Automatisch vom Framework an den entsprechenden Principal Parameter weitergegeben

```java
@GetMapping("somewhere")
public Something getLoggedInUser(Principal principal){
   String username = principal.getName();
   //...
}
```

---

## Aufgabe: Spring Security 4

- Nutze BCrypt Verschlüsselung um die Passwörter zu hashen
- Füge einen neuen GET Endpunkt `/auth/me hinzu`, der den gerade eingeloggten User zurückgibt, ziehe den Namen des Users aus dem Principal.

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
```

```
HMACSHA256(base64UrlEncode(header) + "." + base64UrlEncode(payload),secret
```

```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c
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

- AuthenticationManager kümmert sich um password Validierung
- jwtService Helper für jwt actions

```java

@RestController
@RequestMapping("auth/login")
public class LoginController {
    private final AuthenticationManager authenticationManager;
    private final JWTUtils jwtService;
    //..
    @PostMapping
    public String login(@RequestBody LoginData data) {
        try {
            authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                    data.getName(),
                    data.getPassword())
                );
            return jwtService.createToken(data.getName());
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

`SecurityConfig`

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
