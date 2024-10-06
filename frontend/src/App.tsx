import { useState, useEffect } from 'react';
import './App.css';

const backendUrl = process.env.REACT_APP_CV_CREATOR_BACKEND_URL ?? "."
let initialized =  false

interface Tag {
  label: string;
  value: string;
}

interface LocalizedMenu {
  label: string;
  languageLabel: string;
  tagsLabel: string;
  tags: Tag[];
}

interface LanguageToLocalizedMenu {
  [Key: string]: LocalizedMenu;
}

async function fetchMenu(): Promise<LanguageToLocalizedMenu> {
  const response = await fetch(`${backendUrl}/cvcreator/menu`);
  const data = await response.json();
  return data;
}

function App() {
  const [language, setLanguage] = useState("")
  const [menu, setMenu] = useState<LanguageToLocalizedMenu>({})

  useEffect(() => {
    if (!initialized) {
      setMenu({})
      fetchMenu().then(data => {
        setMenu(data)
        //if isDefault setLanguage
      })
      initialized = true
    }
  }, []);

  const renderedLanguage = Object.keys(menu).map((key: string, index: number) => {
    let checked = false
    if (index === 0) {
      checked = true
    }
    return <div key={key}>
      <label>
        <input type="radio" name="language" value={key} defaultChecked={checked}/>{menu[key].label}
      </label>
    </div>
  })

  return (
    <div>
      <br/>
      <div className="Menu">
        {renderedLanguage}
        <br/>
        <p>{JSON.stringify(menu)}</p>
      </div>
    </div>
  );
}

export default App;
