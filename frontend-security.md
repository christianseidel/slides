---
marp: true
theme: nf-theme
paginate: true
title: Frontend Security
---

# Frontend Security

---

Pulle dir die `frontend` branch und mache dich mit den vorhandenen Komponenten vertraut.

---

## Login

- JWT ziehen und speichern.

- Nutzerdaten (Name, Avatar, Rolle) aus Claims ziehen.

  https://www.npmjs.com/package/jsonwebtoken

  ```javascript
  const claims = jwt.decode(token);
  const user = {
    username: claims.sub,
    avatar: claims.avatar,
    role: claims.role,
  };
  ```

---

Nutze die `Loading` und `Error` Komponenten um das Ergebnis des Requests anzuzeigen.

Leite nach erfolgreichem login auf `/profile` umleiten.

```javascript
if (user) {
  return <Redirect />;
}
```

---

## Routing

Nur `/login` ist von jedem Nutzer erreichbar.

Alle anderen Routen leiten einen nicht eingeloggten Nutzer zu `/login` um.

```javascript
if (!user) {
  return <Redirect to="/login" />;
}
```

**Tipp:** Nur ein Nutzer mit Rolle Admin darf `/admin` betreten.

---

## Protected Route

```javascript
function ProtectedRoute({ user, ...props }) {
  if (user) {
    return <Route {...props} />;
  }

  return <Redirect to="/login" />;
}
```

---

## React Context

Context erstellen

```javascript
export const AuthContext = createContext({});

export function AuthContextProvider({ children }) {
  const [foo, setFoo] = useState("bar");

  return (
    <AuthContext.Provider value={{ foo, setFoo }}>
      {children}
    </AuthContext.Provider>
  );
}
```

---

`AuthContextProvider` als Komponente außen um alles drum legen _(App.js)_ vgl. Router, der auch ein ContextProvider ist.

In anderen Komponenten innerhalb des ContextProviders können die Werte dann abgerufen werden.

```javascript
const { foo, setFoo } = useContext(AuthContext);
```

---

## Nav

Wenn ein Nutzer eingeloggt ist, sieht er in der Navbar den _Logout Link_, ansonsten den _Login Link_.

Wenn der eingeloggte Nutzer die Admin-Rolle hat, sieht er den _Admin Link_.

---

## Logout

Alle lokal gespeicherten Daten (JWT, Claims, Credentials) löschen.

Der JWT läuft von alleine ab.

---

## Admin

Alle Nutzer laden, der Admin selbst soll nicht in der Liste sein.
