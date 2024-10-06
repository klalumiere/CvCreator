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

function createTagsSetFromLocalizedMenu(localizedMenu: LocalizedMenu): Set<string> {
  if(!localizedMenu) {
    return new Set()
  }
  return new Set(localizedMenu.tags.map(tag => tag.value))
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
  const [menu, setMenu] = useState<LanguageToLocalizedMenu>({})
  const [languageKey, setLanguageKey] = useState("")
  const [tags, setTags] = useState<Set<string>>(new Set())

  useEffect(() => {
    if (!initialized) {
      setMenu({})
      fetchMenu().then(data => setMenu(data))
      initialized = true
    }
  }, []);
  useEffect(() => setLanguageKey(getDefaultLanguageKey(menu)), [menu]);
  useEffect(() => setTags(createTagsSetFromLocalizedMenu(menu[languageKey])), [languageKey, menu]);

  function onLanguageChange(event: React.ChangeEvent<HTMLInputElement>) {
    setLanguageKey(event.target.value);
  }

  function onTagChange(event: React.ChangeEvent<HTMLInputElement>) {
    let newTags = new Set(tags)
    if(event.target.checked) {
      newTags.add(event.target.id)
    } else {
      newTags.delete(event.target.id)
    }
    setTags(newTags)
  }

  const languageLabel = languageKey ? menu[languageKey].languageLabel : ""
  const renderedLanguage = Object.keys(menu).sort().map((key: string, index: number) =>
    <div key={key}>
      <label>
        <input 
          defaultChecked={isDefault(menu[key])}
          name="language"
          onChange={onLanguageChange}
          type="radio"
          value={key}
          />{menu[key].label}
      </label>
    </div>
  )

  const tagsLabel = !languageKey ? "" : menu[languageKey].tagsLabel
  const renderedTags = !languageKey ? "" :  menu[languageKey].tags
    .sort((lhs, rhs) => lhs.label < rhs.label ? -1 : 0)
    .map(tag =>
      <div key={tag.value}>
        <label>
          <input 
            checked={tags.has(tag.value)}
            id={tag.value}
            onChange={onTagChange}
            type="checkbox"
            />{tag.label}
        </label>
      </div>
    )

  console.log(tags) // TODO: remove this

  return (
    <div>
      <div className="Menu">
        <br/>
        <strong><div>{languageLabel}</div></strong>
        {renderedLanguage}
        <br/>
        <strong><div>{tagsLabel}</div> </strong>
        {renderedTags}
      </div>
      <div className="Cv"></div>
    </div>
  );
}

export default App;
