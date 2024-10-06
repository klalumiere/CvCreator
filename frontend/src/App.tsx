import { useState, useEffect } from 'react';
import './App.css';

const backendUrl = process.env.REACT_APP_CV_CREATOR_BACKEND_URL ?? "."
let initialized =  false

interface Tag {
  label: string;
  value: string;
}

interface LocalizedMenu {
  default?: boolean;
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

function getDefaultLanguageKey(menu: LanguageToLocalizedMenu): string {
  let defaultLanguageKey = ""
  for (let [key, value] of Object.entries(menu)) {
    if(isDefault(value)) {
      defaultLanguageKey = key
      break
    }
  }
  return defaultLanguageKey
}

function isDefault(localizedMenu: LocalizedMenu): boolean {
  return localizedMenu.default === true
}

function App() {
  const [languageKey, setLanguageKey] = useState("")
  const [menu, setMenu] = useState<LanguageToLocalizedMenu>({})

  useEffect(() => {
    if (!initialized) {
      setMenu({})
      fetchMenu().then(data => setMenu(data))
      initialized = true
    }
  }, []);
  useEffect(() => setLanguageKey(getDefaultLanguageKey(menu)), [menu]);

  const languageLabel = languageKey ? menu[languageKey].languageLabel : ""
  const renderedLanguage = Object.keys(menu).sort().map((key: string, index: number) =>
    <div key={key}>
      <label>
        <input type="radio" name="language" value={key} defaultChecked={isDefault(menu[key])}/>{menu[key].label}
      </label>
    </div>
  )

  const tagsLabel = languageKey ? menu[languageKey].tagsLabel : ""

  return (
    <div>
      <br/>
      <div className="Menu">
        <strong><div>{languageLabel}</div></strong>
        {renderedLanguage}
        <br/>
        <strong><div>{tagsLabel}</div> </strong>
        <p>{JSON.stringify(menu)}</p>
      </div>
    </div>
  );
}

export default App;
