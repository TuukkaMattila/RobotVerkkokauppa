*** Settings ***
Documentation       Esimerkki käyttäen Selenium kirjastoa
Library             SeleniumLibrary

*** Variables ***
${BROWSER}          Chrome

*** Keywords ***

Appstate
    Open Browser                    https://verkkokauppa.com        ${BROWSER}
    MaximizeBrowserWindow
    # Asetetaan default odotusaika
    Set Selenium Timeout            10

AcceptCookies
    WaitUntilElementIsVisible       allow-cookies                   
    ClickElement                    allow-cookies
    WaitUntilElementIsNotVisible    allow-cookies

ifCookies
    ${status}=		                Run Keyword And Return Status	    ElementShouldBeVisible          allow-cookies
    Run Keyword If 					'${status}'=='True'     AcceptCookies
    Run Keyword If 					'${status}'=='False'    Log         No cookies visible

# Vastaanottaa elementin, odottaa sen näkyvän ja klikkaa sitä
WaitAndClickElement
    [Arguments]                     ${locator}
    WaitUntilElementIsVisible       ${locator}
    ClickElement                    ${locator}

WaitAndInputText
    [Arguments]                     ${locator}      ${input}
    WaitUntilElementIsVisible       ${locator}
    InputText                       ${locator}      ${input}
