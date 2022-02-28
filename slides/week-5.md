---
marp: true
theme: nf-theme
paginate: true
title: Java Bootcamp - Template
---

## Wochenübersicht

**Montag:** Freitagsaufgabe, Dataflow

**Dienstag:** Fehlerbehandlung beim `fetch`, Unit Tests im Frontend

**Mittwoch:** React Router, CSS Framework einbinden

**Donnerstag:** Umgebungsvariablen im Frontend, i18n, Local Storage

**Freitag:** Todo-App

---

## Datflow

<!-- _class: hsplit -->

- von oben nach unten über props
- Von unten nach oben über Callback-Funktionen

```javascript
// Parent

export default function Parent() {
    const handleChildChange = () => {
        // do what is needed to do
    };

    return <Child onChildChange={handleChildChange} />;
}

// Child

interface ChildProps {
    onChildChange: () => void;
}

export default function Child(props: ChildProps) {
    const doSomething = () => {
        props.onChildChange();
    };

    return <button onClick={() => doSomething ()}>Click me</button>;
}
```

---

## Fehlerbehandlung beim fetch

<!-- _class: hsplit -->

```javascript
fetch(url)
    .then(response => {
        if (response.status === 200) {
            return response.json();
        }
        throw new Error('My error message');
    })
    .then(todo => setTodo(todo))
    .catch(e => setErrorMessage());
```

```java
@GetMapping("/{id}")
public Todo getToto(@PathVariable String id) {
    Todo todo = service.findById(id);        // Nehmen wir an todo ist null
    todo.performSomeMethodThatIsNecessary(); // Hier kommt es jetzt zur NullPointerException
    return todo;
}
```

---

## React Router

<!-- _class: hsplit -->

- Addon für React
- Verlinkt eine eingegebene Adresse mit den Unterseiten der App
- Keine echte URL, sonste würde der Browser die App nicht mehr aufrufen
- `Link` schreibt einen (pseudo-)Link
- `Route` verknüpft einen Pfad mit einer Komponente

```javascript
function MainPage() {
    return (
        <div>
            <Link to="/index">Inhalt</Link> 
            <Link to="/courses">Kurse</Link>
        </div>
    );
}

//...

function App() {
    return (
        <BrowserRouter>
            <Routes>
                <Route path="/" element={<MainPage />}>
                <Route path="index" element={<Index />} />
                <Route path="courses" element={<Courses />} />
                </Route>
            </Routes>
        </BrowserRouter>
  );
}
```

---

## Formulare

```html
<form action="/submit">
    <h2>Register here</h2>
        <div class="info">
            <input class="fname" type="text" name="name" placeholder="Full name">
            <input type="text" name="name" placeholder="Email">
            <input type="password" name="name" placeholder="Password">
            <select>
                <option value="course-type" selected>Course type*</option>
                <option value="short-courses">Short courses</option>
                <option value="featured-courses">Featured courses</option>
            </select>
        </div>
    <div>
        <input type="checkbox" name="checkbox">I agree to the Privacy Poalicy
    </div>
    <button type="submit" href="/">Submit</button>
</form>
```

---

## Formulare mit React

<!-- _class: hsplit -->

- Problem: State in React vs. Daten in Forms
- Einfach eigene Komponenten machen verletzt den Standard und kann zu Problemen führen
- Lösung: Controlled Components
  - Fangen Ereignisse im Browser
  - Synchronisieren State und Form

```javascript
function NameForm(props) {
    const [value, setValue] = useState('');

    const handleChange = (event) => {
        this.setValue(event.target.value);
    };

    const handleSubmit = (event) => {
        alert('A name was submitted: ' + value);
        event.preventDefault();
    };

    return (
        <form onSubmit={handleSubmit}>
            <label>Name:
            <input type="text" 
                   value={value} 
                   onChange={handleChange} 
            />
            </label>
            <input type="submit" value="Submit" />
        </form>
    );
}
```

---

## Aufgabe Router/Forms

1. Nutze React Router um in der Todo-App die Eingabe und Änderungen über eine eigene Seite durchzuführen.
1. Beschränke die Textlänge auf 1000 und gib einen Fehler aus wenn sie überschritten wird.

---

## Local Storage in React

<!-- _class: hsplit -->

- LocalStorage speichert beliebige Daten im lokalen Browser
- Daten werden nicht automatisch auf andere Geräte übertragen
- **Kann nur Strings speichern** (JSON.stringify / JSON.parse)
- Datenmenge ist begrenzt (je nach Einstellungen 5-10 MB)
- Besser als Cookies

```javascript
const App = () => {
    const STORAGE_KEY = 'myValueKey';

    const [value, setValue] = React.useState(
        localStorage.getItem(STORAGE_KEY) || ''
    );

    React.useEffect(() => {
        localStorage.setItem(STORAGE_KEY, value);
    }, [value]);

    const onChange = event => setValue(event.target.value);

    return (
        <input value={value} type="text" onChange={onChange} />
        <p>{value}</p>
    );
};
```

---

## SCSS

<!-- _class: hsplit -->

- CSS with superpowers
- Erlaubt Variablen, Berechnungen
- Erlaubt CSS simpel zu verschachteln
- Module und Import von Snippets
- Funktionen (Mixins)

```scss
@mixin theme($theme: DarkGray) {
    background: $theme;
    box-shadow: 0 0 1px rgba($theme, .25);
    color: #fff;
}

.output {
    .info {
        @include theme;
    }
    .alert {
        @include theme($theme: DarkRed);
    }
    .success {
        @include theme($theme: DarkGreen);
    }
}
```

---

## SCSS in React

1. Installation des Packages

`$ npm install sass-loader sass`

2. In Webpack einbinden

3. Einbinden in React

`@import 'styles/colors.scss';`

---

## SCSS Aufgaben

1. Binde SCSS in die Todo-App ein
1. Versuche dein CSS durch SCSS zu verbessern
