*** Settings ***
Library                             RequestsLibrary
Library                             OperatingSystem
Library                             SeleniumLibrary                      run_on_failure=Close browser
Variables                           macProVar.yaml
Resource                            KeyWords.robot


*** Test Cases ***

[setup]
    restore category settings
    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacFirewall.Start Yes
    sleep                           10s

Block Adult Content On
    [Documentation]                 Блокировка сайтов для взрослых включена
    [Tags]                          acceptance
    [Teardown]                      run                                 ${Main.cfset} MacFirewall.BlockAdultContent -r

    run                             ${Main.cfset} MacFirewall.BlockAdultContent Yes
    sleep                           1s
    Check Url In Browser            ${Category.adult}                   Сайты для взрослых
    Get code and reason             ${Category.adult}

Block Weapons Content On
    [Documentation]                 Блокировка сайтов с оружием включена
    [Tags]                          acceptance
    [Teardown]                      run                                 ${Main.cfset} MacFirewall.BlockWeapons -r

    run                             ${Main.cfset} MacFirewall.BlockWeapons Yes
    sleep                           1s
    Check Url In Browser            ${Category.weapons}                 Оружие
    Get code and reason             ${Category.weapons}

Block Gambling Content On
    [Documentation]                 Блокировка сайтов с азартными играми включена
    [Tags]                          acceptance
    [Teardown]                      run                                 ${Main.cfset} MacFirewall.BlockGambling -r

    run                             ${Main.cfset} MacFirewall.BlockGambling Yes
    sleep                           1s
    Check Url In Browser            ${Category.gambling}                Азартные игры
    Get code and reason             ${Category.gambling}

Block Drugs Content On
    [Documentation]                 Блокировка сайтов с наркотиками включена
    [Tags]                          acceptance
    [Teardown]                      run                                 ${Main.cfset} MacFirewall.BlockDrugs -r

    run                             ${Main.cfset} MacFirewall.BlockDrugs Yes
    sleep                           1s
    Check Url In Browser            ${Category.drugs}                   Наркотики
    Get code and reason             ${Category.drugs}

Block ObsceneLanguage Content On
    [Documentation]                 Блокировка сайтов с нецензурной лексикой включена
    [Tags]                          acceptance
    [Teardown]                      run                                 ${Main.cfset} MacFirewall.BlockObsceneLanguage -r

    run                             ${Main.cfset} MacFirewall.BlockObsceneLanguage Yes
    sleep                           1s
    Check Url In Browser            ${Category.obslang}                 Нецензурная лексика
    Get code and reason             ${Category.obslang}

Block Chats Content On
    [Documentation]                 Блокировка сайтов с чатами включена
    [Tags]                          acceptance
    [Teardown]                      run                                 ${Main.cfset} MacFirewall.BlockChats -r

    run                             ${Main.cfset} MacFirewall.BlockChats Yes
    sleep                           1s
    Check Url In Browser            ${Category.chats}                   Чаты
    Get code and reason             ${Category.chats}

Block Terrorism Content On
    [Documentation]                 Блокировка сайтов с терроризмом включена
    [Tags]                          acceptance
    [Teardown]                      run                                 ${Main.cfset} MacFirewall.BlockTerrorism -r

    run                             ${Main.cfset} MacFirewall.BlockTerrorism Yes
    sleep                           1s
    Check Url In Browser            ${Category.terrorism}               Терроризм
    Get code and reason             ${Category.terrorism}

Block FreeEmail Content On
    [Documentation]                 Блокировка сайтов с имейл включена
    [Tags]                          acceptance
    [Teardown]                      run                                 ${Main.cfset} MacFirewall.BlockFreeEmail -r

    run                             ${Main.cfset} MacFirewall.BlockFreeEmail Yes
    sleep                           1s
    Check Url In Browser            ${Category.freeemail}               Почта
    Get code and reason             ${Category.freeemail}

Block SocialNetworks Content On
    [Documentation]                 Блокировка сайтов социальных сетей включена
    [Tags]                          acceptance
    [Teardown]                      run                                 ${Main.cfset} MacFirewall.BlockSocialNetworks -r

    run                             ${Main.cfset} MacFirewall.BlockSocialNetworks Yes
    sleep                           1s
    Check Url In Browser            ${Category.socialnet}               Социальные сети
    Get code and reason             ${Category.socialnet}

Block Not Recommended On
    [Documentation]                 Блокировка не рекомендуемых сайтов включена
    [Tags]                          acceptance
    [Teardown]                      run                                 ${Main.cfset} MacFirewall.BlockNotRecommended -r

    run                             ${Main.cfset} MacFirewall.BlockNotRecommended Yes
    sleep                           1s
    Check Url In Browser            ${Category.notrcm}   	            Нерекомендуемый сайт
    Get code and reason             ${Category.notrcm}

Block Anonymizers On
    [Documentation]                 Блокировка сайтов анонимайзеров включена
    [Tags]                          acceptance
    [Teardown]                      run                                 ${Main.cfset} MacFirewall.BlockNotRecommended -r

    run                             ${Main.cfset} MacFirewall.BlockNotRecommended Yes
    sleep                           1s
    Check Url In Browser            ${Category.anonymizer}   	        Нерекомендуемый сайт
    Get code and reason             ${Category.anonymizer}

Block Due To Copyright Notice On
    [Documentation]                 Блокировка сайтов по обращению правообладателя включена
    [Tags]                          acceptance
    [Teardown]                      run                                 ${Main.cfset} MacFirewall.BlockDueToCopyrightNotice -r

    run                             ${Main.cfset} MacFirewall.BlockDueToCopyrightNotice Yes
    run                             ${Main.cfset} MacFirewall.BlockNotRecommended No
    Open Browser	                ${Category.copyright}  	            Chrome
    sleep                           1s
    Page Should Contain             По обращению правообладателя
    Page Should Contain             URL заблокирован SpIDer Gate
    Close Browser
    Get code and reason             ${Category.copyright}

Block Known Virus Ok
    [Documentation]                 SpiderGate известные вирусы
    [Tags]                          acceptance
    Open Browser	                ${Category.knownvirus}  	        Chrome
    sleep                           1s
    Page Should Contain             Источник распространения вирусов
    Page Should Contain             URL заблокирован SpIDer Gate
    Close Browser
    Get code and reason             ${Category.knownvirus}

Safe search On
    [Documentation]                 SpiderGate безопасный поиск включено
    [Tags]                          test2
    run                             ${Main.cfset} MacFirewall.UnwrapSsl Yes
    run                             ${Main.cfset} MacFirewall.HttpSafeSearch Yes
    ${result} =                     run                                 curl -v -k -o nil https://www.yandex.ru/search?text=porn
    log                             ${result}
    ${result} =                     Convert To String                   ${result}
    should contain any              ${result}                           family
    run                             ${Main.cfset} MacFirewall.UnwrapSsl -r
    run                             ${Main.cfset} MacFirewall.HttpSafeSearch -r
