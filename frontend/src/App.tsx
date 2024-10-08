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


function createTagsSetFromLocalizedMenu(menu: LocalizedMenu): Set<string> {
  if(!menu) {
    return new Set()
  }
  return new Set(menu.tags.map(tag => tag.value))
}

async function fetchCv(language: string, tags: Set<string>): Promise<string> {
  if(!language) {
    return Promise.resolve("")
  }
  const response = await fetch(`${backendUrl}/cvcreator?language=${language}&tags=${joinTags(tags)}`);
  const data = await response.text();
  return data;
}

async function fetchMenus(): Promise<LanguageToLocalizedMenu> {
  const response = await fetch(`${backendUrl}/cvcreator/menus`);
  const data = await response.json();
  return data;
}

function joinTags(tags: Set<string>) {
  return Array.from(tags).join(",")
}

function getDefaultLanguageKey(menus: LanguageToLocalizedMenu): string {
  const firstKey = Object.keys(menus).find(Boolean)
  return Object.entries(menus)
    .filter(([_, menu]) => menu.default === true)
    .reduce((accumulator, [key, _]) => key, firstKey) ?? ""
}


function App() {
  const [menus, setMenus] = useState<LanguageToLocalizedMenu>({})
  const [languageKey, setLanguageKey] = useState("")
  const [tags, setTags] = useState<Set<string>>(new Set())
  const [cv, setCv] = useState("")

  useEffect(() => {
    if (!initialized) {
      setMenus({})
      fetchMenus().then(data => setMenus(data))
      initialized = true
    }
  }, []);
  useEffect(() => setLanguageKey(getDefaultLanguageKey(menus)), [menus]);
  useEffect(() => setTags(createTagsSetFromLocalizedMenu(menus[languageKey])), [languageKey, menus]);
  useEffect(() => { fetchCv(languageKey, tags).then(data => setCv(data)) }, [languageKey, tags]);


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


  const languageLabel = languageKey ? menus[languageKey].languageLabel : ""
  const renderedLanguage = Object.keys(menus).sort().map((key: string, _: number) =>
    <div key={key}>
      <label>
        <input 
          checked={languageKey === key}
          name="language"
          onChange={onLanguageChange}
          type="radio"
          value={key}
          />{menus[key].label}
      </label>
    </div>
  )

  const tagsLabel = !languageKey ? "" : menus[languageKey].tagsLabel
  const renderedTags = !languageKey ? "" :  menus[languageKey].tags
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
      <div className="Cv">
        { <div dangerouslySetInnerHTML={{ __html: cv }} /> }
      </div>
    </div>
  );
}

export default App;
