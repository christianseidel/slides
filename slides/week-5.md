---
marp: true
theme: nf-theme
paginate: true
title: Java Bootcamp - Template
---

## Wochenübersicht

**Montag:** React State, Hooks

**Dienstag:** React Router, Formulare

**Mittwoch:** Local Storage, SCSS, TypeScript

**Donnerstag:** Todo-App in TypeScript

**Freitag:** Todo-App in TypeScript

---

## React State

<!-- _class: hsplit -->

- Nur bei "stateful" Komponenten möglich
- Ähnlich wie Props, aber können geändert werden
- Änderung immer über `setState`
- `setState` braucht nur die geänderten Werte (merge)

```javascript
class Clock extends React.Component {
  constructor(props) {
    super(props);
    this.state = {date: new Date()};
  }

  tick() {
    this.setState({
      date: new Date()
    });
  }

  render() {
    const time = this.state.date
        .toLocaleTimeString();
    return (
      <div>
        <h1>Hello, world!</h1>
        <h2>It is {time}.</h2>
      </div>
    );
  }
}
```

---

## React Conditional Rendering

<!-- _class: hsplit -->

- Erlaubt dynamische Webseiten
- Um die Komponente gar nicht zu renden kann `null` zurück gegeben werden

```javascript
function UserGreeting(props) {
  return <h1>Welcome back!</h1>;
}

function GuestGreeting(props) {
  return <h1>Please sign up.</h1>;
}

function Greeting(props) {
  const isLoggedIn = props.isLoggedIn;
  if (isLogged) {
    return <UserGreeting />;
  } else {
    return <GuestGreeting />;
  }
}
```

---

## React Hooks

<!-- _class: hsplit -->

- Erlaubt einen `state` in function components
- function components sind performanter als class components
- `useState` ermöglicht eine einzelne Variable in den State zu packen
- `useEffect` erlaubt Änderungen außerhalb der Komponente vorzunehmen 

```javascript
function Example() {
    const [count, setCount] = useState(0);

    useEffect(() => {
        document.title = `You clicked ${count} times`;
    });
  
    const increaseCount = () => setCount(count + 1)

    return (
        <div>
            <p>You clicked {count} times</p>
            <button onClick={increaseCount}>
                Click me
            </button>
        </div>
    );
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
