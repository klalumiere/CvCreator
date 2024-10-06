import { useState, useEffect } from 'react';
import logo from './logo.svg';
import './App.css';

const backendUrl = process.env.REACT_APP_CV_CREATOR_BACKEND_URL ?? "."
let initialized =  false

async function fetchMenu(): Promise<any> {
  const response = await fetch(`${backendUrl}/cvcreator/menu`);
  const data = await response.json();
  return data;
}

function App() {
  const [menu, setMenu] = useState(null);

  useEffect(() => {
    if (!initialized) {
      setMenu(null)
      fetchMenu().then(data => setMenu(data))
      initialized = true
    }
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.tsx</code> and save to reload.
          {JSON.stringify(menu)}
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

export default App;
