

import userEvent from '@testing-library/user-event'
import {render, screen} from "@testing-library/react"
import * as AppModule from "./App"

const aTagInEnglish: AppModule.Tag = { value: "testComputerScience", label: "Computer Science" }
const anotherTagInEnglish: AppModule.Tag = { value: "testFood", label: "Food" }
const aTagInFrench: AppModule.Tag = { value: "testComputerScience", label: "Informatique" }
const anotherTagInFrench: AppModule.Tag = { value: "testFood", label: "Nourriture" }
const cvData = "SomeTestCvData"
const languageLabelEnglish = "english"
const languageLabelFrench = "french"

let aLanguageToLocalizedMenu: AppModule.LanguageToLocalizedMenu
let mockFetchCv: jest.SpyInstance
let mockFetchMenus: jest.SpyInstance

function getTestIdForLanguage(language: string): string {
  return `language-input-${aLanguageToLocalizedMenu[language].label}`
}

function getTestIdForTag(tagValue: string): string {
  return `tag-input-${tagValue}`
}


beforeEach(() => {
  aLanguageToLocalizedMenu = {}
  aLanguageToLocalizedMenu[languageLabelEnglish] = {
    default: false,
    label: "TestEnglish",
    languageLabel: "TestLanguage",
    tagsLabel: "TestSkills",
    tags: [aTagInEnglish, anotherTagInEnglish],
  }
  aLanguageToLocalizedMenu[languageLabelFrench] = {
    default: false,
    label: "TestFrancais",
    languageLabel: "TestLangue",
    tagsLabel: "TestCompentence",
    tags: [aTagInFrench, anotherTagInFrench],
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

test('given many languages in menu, only one of them is checked', async () => {
  render(<AppModule.App/>)

  const inputBoxEnglish = await screen.findByTestId(getTestIdForLanguage(languageLabelEnglish)) as HTMLInputElement
  const inputBoxFrench = await screen.findByTestId(getTestIdForLanguage(languageLabelFrench)) as HTMLInputElement
  expect(inputBoxEnglish.checked).not.toEqual(inputBoxFrench.checked)
})

test('given many languages in menu, default is checked', async () => {
  aLanguageToLocalizedMenu[languageLabelFrench].default = true

  render(<AppModule.App/>)

  const inputBoxFrench = await screen.findByTestId(getTestIdForLanguage(languageLabelFrench)) as HTMLInputElement
  expect(inputBoxFrench.checked).toEqual(true)
})

test('when changing languages, cv is fetched with proper language', async () => {
  const user = userEvent.setup()
  aLanguageToLocalizedMenu[languageLabelEnglish].default = true

  render(<AppModule.App/>)
  const inputBoxFrench = await screen.findByTestId(getTestIdForLanguage(languageLabelFrench)) as HTMLInputElement
  await user.click(inputBoxFrench)

  const inputBoxEnglish = await screen.findByTestId(getTestIdForLanguage(languageLabelEnglish)) as HTMLInputElement
  expect(inputBoxEnglish.checked).toEqual(false)
  expect(inputBoxFrench.checked).toEqual(true)
  expect(mockFetchCv).toHaveBeenCalledWith(languageLabelFrench, expect.any(Set))
})

test('joinTags join tags with a coma', () => {
  const result = AppModule.joinTags(new Set(["super", "man"]))
  expect(result).toContain("super")
  expect(result).toContain("man")
  expect(result).toMatch(/\w+,\w+/i)
})

test('screen contains tags label', async () => {
  aLanguageToLocalizedMenu[languageLabelEnglish].default = true

  render(<AppModule.App/>)

  expect(await screen.findByText(aTagInEnglish.label)).toBeInTheDocument()
  expect(await screen.findByText(anotherTagInEnglish.label)).toBeInTheDocument()
})

test('screen contains tags label for its language', async () => {
  aLanguageToLocalizedMenu[languageLabelFrench].default = true

  render(<AppModule.App/>)

  expect(await screen.findByText(aTagInFrench.label)).toBeInTheDocument()
  expect(await screen.findByText(anotherTagInFrench.label)).toBeInTheDocument()
})

test('every tag are checked by default', async () => {
  aLanguageToLocalizedMenu[languageLabelEnglish].default = true

  render(<AppModule.App/>)

  const aTagCheckbox = await screen.findByTestId(getTestIdForTag(aTagInEnglish.value)) as HTMLInputElement
  const anotherTagCheckbox = await screen.findByTestId(getTestIdForTag(anotherTagInEnglish.value)) as HTMLInputElement
  expect(aTagCheckbox.checked).toEqual(true)
  expect(anotherTagCheckbox.checked).toEqual(true)
})

test('when changing tags, cv is fetched with proper tags', async () => {
  const user = userEvent.setup()
  aLanguageToLocalizedMenu[languageLabelEnglish].default = true

  render(<AppModule.App/>)
  const aTagCheckbox = await screen.findByTestId(getTestIdForTag(aTagInEnglish.value)) as HTMLInputElement
  await user.click(aTagCheckbox)

  expect(aTagCheckbox.checked).toEqual(false)
  expect(mockFetchCv).toHaveBeenCalledWith(languageLabelEnglish, new Set([anotherTagInEnglish.value]))
})
