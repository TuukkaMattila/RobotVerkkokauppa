*** Settings ***
Documentation       Esimerkki käyttäen Selenium kirjastoa
Library             SeleniumLibrary

*** Variables ***
${BROWSER}          Chrome

*** Keywords ***

Appstate
    Open Browser                    https://verkkokauppa.com        ${BROWSER}
    MaximizeBrowserWindow

AcceptCookies
    WaitUntilElementIsVisible       allow-cookies                   
    ClickElement                    allow-cookies
    WaitUntilElementIsNotVisible    allow-cookies

# Vastaanottaa elementin, odottaa sen näkyvän ja klikkaa sitä
WaitAndClickElement
    [Arguments]                     ${locator}
    WaitUntilElementIsVisible       ${locator}
    ClickElement                    ${locator}

WaitAndInputText
    [Arguments]                     ${locator}      ${input}
    WaitUntilElementIsVisible       ${locator}
    InputText                       ${locator}      ${input}
