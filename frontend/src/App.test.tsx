import renderer from 'react-test-renderer';
import {screen} from "@testing-library/react";
import * as AppModule from "./App";

const aLanguageToLocalizedMenu: AppModule.LanguageToLocalizedMenu = {}
aLanguageToLocalizedMenu["english"] = {
  default: false,
  label: "TestEnglish",
  languageLabel: "TestLanguage",
  tagsLabel: "TestTags",
  tags: [],
}

test('renders learn react link', async () => {
  jest.spyOn(AppModule, 'fetchMenus').mockImplementation(() => {
    return Promise.resolve(aLanguageToLocalizedMenu)
  });
  jest.spyOn(AppModule, 'fetchCv').mockImplementation(() => {
    return Promise.resolve("")
  });

  renderer.create(<AppModule.App/>);

  expect(await screen.findByText(aLanguageToLocalizedMenu["english"].languageLabel)).toBeInTheDocument();
});
