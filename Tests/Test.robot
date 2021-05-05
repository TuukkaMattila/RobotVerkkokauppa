*** Settings ***
# Lukee resources tiedoston käyttöön (mm. kirjastot)
Resource            D:/Koulu/TeknologiatLopputyö/Resourses/Keywords.robot
# Testien jälkeen tehtävät toimenpiteet
Suite Teardown      CloseAllBrowsers

# Testien ajo: robot Test.robot
# Tarkemmat lokitiedot robot -L TRACE Test.robot 

# Muuttuja samassa tiedostossa missä sitä käytetään.
*** Variables ***
${games}        //*[@id="sidebar-item-24a"]


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
    ifCookies
    WaitAndClickElement             //span[text()="Sileä punottu kaapeli"]
    #Käyttäen Stringiä lokaattorina
    ClickElement                    //a[text()="OMEN Vector -pelihiiri, musta"]
    Sleep                           2
    ClickElement                    //*[@id="main"]/section/aside/div[2]/div[2]/div[1]/div[2]/button[1]/span
    # Avaa komentorivillä Debuggerin
    # Debug
    # Palauttaa selaimen takaisin landing pagelle jotta seuraava testi voi aloittaa ns. puhtaalta pöydältä.
    [Teardown]                      GoTo                                            https://verkkokauppa.com

createCustomerFailed
    WaitUntilElementIsVisible       //*[@class="VkLogo-sc-1l5lj7b-0 epjMnT"]
    ifCookies
    InputText                       //input[@aria-label="Kirjoita hakusana"]        Omen pelihiiri
    ClickElement                    //button[@aria-label="Hae"]
    # Haettiin XPath spanin tekstillä
    WaitUntilElementIsVisible       //span[text()="Haku"]
    #Klikkaa teksti elementtiä ja sulkee haku ikkunan joka estää etenemisen
    WaitAndClickElement             //span[text()="Sileä punottu kaapeli"]
    #Käyttäen Stringiä lokaattorina
    ClickLink                       OMEN Vector -pelihiiri, musta
    Sleep                           2
    #Suoraan chromesta kopioitu XPath "Lisää ostoskoriin" painikkeelle (huom todella vaikea ymmärtää mitä elementtiä tarkoitetaan)
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
    # Jos elementillä on id, voi sen usein kopioida suoraan "kauniissa muodossa"
    ClickElement                    //*[@id="create-account-button"]
    # Luodaan muuttuja joka palauttaa boolean arvon true
    ${status}                       RunKeywordAndReturnStatus
    # ... jatkaa muuttujan luontia toiselle riville
    ...                             WaitUntilPageContains                           Virheellinen puhelinnumero
    RunKeywordIf                    ${status}
    ...                             Log         Puhelinnumero on Virheellinen       WARN
    ...                             ELSE        fail                                Näin ei pitäisi tapahtua
    [Teardown]                      GoTo                                            https://verkkokauppa.com

addSuosituinTuote
    [Documentation]                 Tehdään testi joka hakee sivupalkin kauppa pelit osion ja avaa 
    ...                             tuotealueen selautimpien tuotealueen ensimmäisen tuotteen
    WaitUntilElementIsVisible       //*[@class="VkLogo-sc-1l5lj7b-0 epjMnT"]
    ifCookies
    WaitAndClickElement             //*[@class="sc-2stjer-2 sc-1v44j9-0 khMhcJ gVraGL"]
    # Tehtiin XPathista muuttuja jotta se on helpommin luettava (//*[@id="sidebar-item-24a"] ei kuvaa elementtiä)
    WaitAndClickElement             ${games}
    WaitUntilElementIsVisible       //*[@id="tabs-page-select-tab0"]
    Sleep                           2
    # Selenium kirjaston oma keyword scrollaamiselle (Huom ei toiminut käyttäjän rekisteröinti kohdassa)
    # Divien paikka vaihtelee joten tarkennetaan että divin tulee sisältää teksti "Tuotealueen selatuimpia tuotteita"
    ScrollElementIntoView           //*[@id="category-display-window"]/div[contains(string(), "Tuotealueen selatuimpia tuotteita")]
    # Ikkunassa tuotteet vaihtuu. Robotti valitsee aina ikkunan ensimmäisen tuotteen.
    WaitAndClickElement             //*[@id="category-display-window"]/div[2]/div/ol/li[1]
    WaitUntilElementIsVisible       //*[@class="Button-mt7im1-0 ihpnqE"][contains(string(), "Lisää ostoskoriin")]
    # Käytännössä turha viimeisessä testissä sillä suite teardown sulkee selaimen
    [Teardown]                      GoTo                                            https://verkkokauppa.com
