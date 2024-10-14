
import {render, screen} from "@testing-library/react";
import * as AppModule from "./App";

const cvData = "SomeTestCvData"
const languageLabelEnglish = "english"
const languageLabelFrench = "french"

let aLanguageToLocalizedMenu: AppModule.LanguageToLocalizedMenu
let mockFetchCv: jest.SpyInstance
let mockFetchMenus: jest.SpyInstance


beforeEach(() => {
  aLanguageToLocalizedMenu = {}
  aLanguageToLocalizedMenu[languageLabelEnglish] = {
    default: false,
    label: "TestEnglish",
    languageLabel: "TestLanguage",
    tagsLabel: "TestSkills",
    tags: [],
  }
  aLanguageToLocalizedMenu[languageLabelFrench] = {
    default: false,
    label: "TestFrancais",
    languageLabel: "TestLangue",
    tagsLabel: "TestCompentence",
    tags: [],
  }

  AppModule.resetInitializedForTests()
  mockFetchCv = jest.spyOn(AppModule, 'fetchCv').mockImplementation(() => Promise.resolve(cvData) )
  mockFetchMenus = jest.spyOn(AppModule, 'fetchMenus').mockImplementation(() => Promise.resolve(aLanguageToLocalizedMenu))
})

afterEach(() => {
  mockFetchCv.mockRestore()
  mockFetchMenus.mockRestore()
})

test('screen contains menu data', async () => {
  render(<AppModule.App/>)
  expect(await screen.findByText(aLanguageToLocalizedMenu[languageLabelEnglish].label)).toBeInTheDocument()
})

test('screen contains cv data', async () => {
  render(<AppModule.App/>)
  expect(await screen.findByText(cvData)).toBeInTheDocument()
})

test('given many languages in menu, one of them is checked', async () => {
  render(<AppModule.App/>)

  const inputBoxEnglish = await screen.findByTestId(`language-input-${aLanguageToLocalizedMenu[languageLabelEnglish].label}`) as HTMLInputElement
  const inputBoxFrench = await screen.findByTestId(`language-input-${aLanguageToLocalizedMenu[languageLabelFrench].label}`) as HTMLInputElement
  expect(inputBoxEnglish.checked).not.toEqual(inputBoxFrench.checked)
})

test('given many languages in menu, default is checked', async () => {
  aLanguageToLocalizedMenu[languageLabelFrench].default = true

  render(<AppModule.App/>)

  const inputBoxFrench = await screen.findByTestId(`language-input-${aLanguageToLocalizedMenu[languageLabelFrench].label}`) as HTMLInputElement
  expect(inputBoxFrench.checked).toEqual(true)
})

// test('when changing languages, cv is fetched', async () => {
//   aLanguageToLocalizedMenu[languageLabelEnglish].default = true

//   render(<AppModule.App/>)
//   const inputBoxEnglish = await screen.findByTestId(`language-input-${aLanguageToLocalizedMenu[languageLabelEnglish].label}`) as HTMLInputElement
//   const inputBoxFrench = await screen.findByTestId(`language-input-${aLanguageToLocalizedMenu[languageLabelFrench].label}`) as HTMLInputElement
//   fireEvent.change(inputBoxFrench, {checked: true})

//   // expect(inputBoxEnglish.checked).toEqual(false)
//   expect(inputBoxFrench.checked).toEqual(true)
// })
