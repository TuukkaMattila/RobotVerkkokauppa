*** Settings ***
Library             SeleniumLibrary
Library             DebugLibrary
Resource            D:/Koulu/TeknologiatLopputyö/Resourses/Keywords.robot
#Suite Teardown      CloseAllBrowsers

# Testien ajo: robot Test.robot
# Tarkemmat lokitiedot robot -L TRACE Test.robot 

*** Test Cases ***

NavigateToVerkkokauppa
    Appstate

useSearchBar
    #Käyttäen XPath lokaattorina
    PageShouldContainElement        //*[@class="VkLogo-sc-1l5lj7b-0 epjMnT"]
    InputText                       //input[@aria-label="Kirjoita hakusana"]        Omen pelihiiri
    ClickElement                    //button[@aria-label="Hae"]
    # Haettiin XPath spanin tekstillä
    WaitUntilElementIsVisible       //span[text()="Haku"]
    AcceptCookies
    WaitAndClickElement             //span[text()="Sileä punottu kaapeli"]
    #Käyttäen Stringiä lokaattorina
    ClickElement                    //a[text()="OMEN Vector -pelihiiri, musta"]
    Sleep                           2
    ClickElement                    //*[@id="main"]/section/aside/div[2]/div[2]/div[1]/div[2]/button[1]/span
    # Avaa komentorivillä Debuggerin:
    # Debug
    [Teardown]                      GoTo                                            https://verkkokauppa.com

createCustomerFailed
    WaitUntilElementIsVisible       //*[@class="VkLogo-sc-1l5lj7b-0 epjMnT"]
    InputText                       //input[@aria-label="Kirjoita hakusana"]        Omen pelihiiri
    ClickElement                    //button[@aria-label="Hae"]
    # Haettiin XPath spanin tekstillä
    WaitUntilElementIsVisible       //span[text()="Haku"]
    #Klikkaa teksti elementtiä ja sulkee haku ikkunan
    WaitAndClickElement             //span[text()="Sileä punottu kaapeli"]
    #Käyttäen Stringiä lokaattorina
    ClickLink                       OMEN Vector -pelihiiri, musta
    Sleep                           2
    #Suoraan chromesta kopioitu XPath
    ClickElement                    //*[@id="main"]/section/aside/div[2]/div[2]/div[1]/div[2]/button[1]/span
    WaitAndClickElement             //span[text()="Siirry kassalle"]
    WaitUntilElementIsVisible       //h2[@class="vk-step-title vk-step-title--cart"]
    WaitAndClickElement             //span[text()="Seuraava"]
    Sleep                           1
    SelectFrame                     //*[@id="login-iframe"]
    # Käytetään javascript komentoa scrollaamaan alas sivulla
    ExecuteJavascript               document.getElementById("register-button").scrollIntoView()
    WaitAndClickElement             //*[@id="register-button"]
    #Lokittaa vapaamuotoista tekstiä ja muuttujia
    Log                             Päästiin käyttäjätilin luontiin
    WaitAndInputText                email           test.test@testmail.test
    InputPassword                   password        12345678
    InputText                       firstname       Tuukka
    InputText                       lastname        Mattila
    InputText                       phoneMobile     puhelinnumero
    SelectFromListByValue           language        en
    # Haetaan osittainen merkkijono (XPath)
    # Haetaan useasta samasta elementistä haluttu
    ClickElement                    (//*[@class="selector selector--checkbox "])[2]
    # Muuttuja mihin tallennetaan   Avainsana                   Elementti mistä haetaan         Mikä attribuutti
    ${checkbox_value}               GetElementAttribute         //*[@id="tos-accepted"]         value
    # Vertaa kahta tekstiä
    ShouldBeEqual                   ${checkbox_value}   true
    ClickElement                    //*[@id="create-account-button"]
    # Luodaan muuttuja joka palauttaa boolean arvon true
    ${status}                       RunKeywordAndReturnStatus
    # ... jatkaa muuttujan luontia toiselle riville
    ...                             WaitUntilPageContains                           Virheellinen puhelinnumero
    RunKeywordIf                    ${status}
    ...                             Log         Puhelinnumero on Virheellinen       WARN
    ...                             ELSE        fail                                Näin ei pitäisi tapahtua

    



    