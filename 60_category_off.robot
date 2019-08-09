*** Settings ***

Library                             RequestsLibrary
Library                             OperatingSystem
Library                             SeleniumLibrary                         run_on_failure=Close browser
Variables                           macProVar.yaml
Resource                            KeyWords.robot

*** Test Cases ***

[setup]
    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacFirewall.Start Yes
    sleep                           10s

SpIDer Gate OFF
    [Documentation]                 Отключение Spider Gate
    [Tags]                          acceptance
    [Teardown]                      run                                     ${Main.cfset} MacFirewall.Start -r
    ${default value} =              run                                     ${Main.cfshow} MacFirewall.Start
    Log                             SpIDer Gate = ${default value}
    run                             ${Main.cfset} MacFirewall.Start No
    Create Session                  NotRecommended                          ${Category.notrcm}                  verify=${False}
    ${resp} =                       Get Request                             NotRecommended                      /

    Should not Be Equal As Strings  ${resp.status_code}                     403

Block Adult Content Off
    [Documentation]                 Блокировка сайтов для взрослых включена
    [Tags]                          acceptance
    [Teardown]                      run                                     ${Main.cfset} MacFirewall.BlockAdultContent -r
    run                             ${Main.cfset} MacFirewall.BlockAdultContent No
    sleep                           1s
    Check url in browser Not        ${Category.adult}
    Get code and reason Not         ${Category.adult}

Block Violence Content Off
    [Documentation]                 Блокировка сайтов с насилием отключена
    [Tags]                          acceptance
    [Teardown]                      run                                     ${Main.cfset} MacFirewall.BlockViolence -r
    run                             ${Main.cfset} MacFirewall.BlockViolence No
    sleep                           1s
    Check url in browser Not        ${Category.violence}
    Get code and reason Not          ${Category.violence}

Block Weapons Content Off
    [Documentation]                 Блокировка сайтов с оружием отключена
    [Tags]                          acceptance
    [Teardown]                      run                                     ${Main.cfset} MacFirewall.BlockWeapons -r
    run                             ${Main.cfset} MacFirewall.BlockWeapons No
    sleep                           1s
    Check url in browser Not        ${Category.weapons}
    Get code and reason Not         ${Category.weapons}

Block Gambling Content Off
    [Documentation]                 Блокировка сайтов с азартными играми отключена
    [Tags]                          acceptance
    [Teardown]                      run                                     ${Main.cfset} MacFirewall.BlockGambling -r
    run                             ${Main.cfset} MacFirewall.BlockGambling No
    sleep                           1s
    Check url in browser Not        ${Category.gambling}
    Get code and reason Not         ${Category.gambling}

Block Drugs Content Off
    [Documentation]                 Блокировка сайтов с наркотиками отключена
    [Tags]                          acceptance
    [Teardown]                      run                                     ${Main.cfset} MacFirewall.BlockDrugs -r
    run                             ${Main.cfset} MacFirewall.BlockDrugs No
    sleep                           1s
    Check url in browser Not        ${Category.drugs}
    Get code and reason Not         ${Category.drugs}

Block ObsceneLanguage Content Off
    [Documentation]                 Блокировка сайтов с нецензурной лексикой отключена
    [Tags]                          acceptance
    [Teardown]                      run                                     ${Main.cfset} MacFirewall.BlockObsceneLanguage -r
    run                             ${Main.cfset} MacFirewall.BlockObsceneLanguage No
    sleep  1s
    Check url in browser Not        ${Category.obslang}
    Get code and reason Not         ${Category.obslang}

Block Chats Content Off
    [Documentation]                 Блокировка сайтов с чатами отключена
    [Tags]                          acceptance
    [Teardown]                      run                                     ${Main.cfset} MacFirewall.BlockChats -r
    run                             ${Main.cfset} MacFirewall.BlockChats No
    sleep                           1s
    Check url in browser Not        ${Category.chats}
    Get code and reason Not         ${Category.chats}

Block Terrorism Content Off
    [Documentation]                 Блокировка сайтов с терроризмом отключена
    [Tags]                          acceptance
    [Teardown]                      run                                      ${Main.cfset} MacFirewall.BlockTerrorism -r
    run                             ${Main.cfset} MacFirewall.BlockTerrorism No
    sleep                           1s
    Check url in browser Not        ${Category.terrorism}
    Get code and reason Not         ${Category.terrorism}

Block FreeEmail Content Off
    [Documentation]                 Блокировка сайтов с электронной почтой отключена
    [Tags]                          acceptance
    [Teardown]                      run                                     ${Main.cfset} MacFirewall.BlockFreeEmail -r
    run                             ${Main.cfset} MacFirewall.BlockFreeEmail No
    sleep                           1s
    Check url in browser Not        ${Category.freeemail}
    Get code and reason Not         ${Category.freeemail}

Block SocialNetworks Content Off
    [Documentation]                 Блокировка сайтов социальных сетей отключена
    [Tags]                          acceptance
    [Teardown]                      run                                     ${Main.cfset} MacFirewall.BlockSocialNetworks -r
    run                             ${Main.cfset} MacFirewall.BlockSocialNetworks No
    sleep                           1s
    Check url in browser Not        ${Category.socialnet}
    Get code and reason Not         ${Category.socialnet}

Block Not Recommended Off
    [Documentation]                 Блокировка не рекомендованных сайтов отключена
    [Tags]                          acceptance
    [Teardown]                      run                                     ${Main.cfset} MacFirewall.BlockNotRecommended -r
    run                             ${Main.cfset} MacFirewall.BlockNotRecommended No
    sleep                           1s
    Check url in browser Not        ${Category.notrcm}
    Get code and reason Not         ${Category.notrcm}

Block Anonymizers Off
    [Documentation]                 Блокировка сайтов анонимайзеров отключена
    [Tags]                          acceptance
    [Teardown]                      run                                     ${Main.cfset} MacFirewall.BlockNotRecommended -r

    run                             ${Main.cfset} MacFirewall.BlockNotRecommended No
    sleep                           1s
    Check url in browser Not        ${Category.anonymizer}
    Get code and reason Not         ${Category.anonymizer}

Block Due To Copyright Notice Off
    [Documentation]                 Блокировка сайтов по просьбе правообладателя отключена
    [Tags]                          acceptance
    [Teardown]                      run                                     ${Main.cfset} MacFirewall.BlockDueToCopyrightNotice -r

    run                             ${Main.cfset} MacFirewall.BlockDueToCopyrightNotice No
    run                             ${Main.cfset} MacFirewall.BlockNotRecommended No
    Open Browser	                ${Category.copyright} 	Chrome
    sleep                           1s
    Page Should Not Contain         По обращению правообладателя
    Page Should Not Contain         URL заблокирован SpIDer Gate
    Close Browser
    Get code and reason Not         ${Category.copyright}

Safe search Off
    [Documentation]                 SpiderGate безопасный поиск включено
    [Tags]                          acceptance
    run                             ${Main.cfset} MacFirewall.UnwrapSsl No
    run                             ${Main.cfset} MacFirewall.HttpSafeSearch No
    ${result} =                     run                                     curl -v -k -o nil https://www.yandex.ru/search?text=porn
    log                             ${result}
    ${result} =                     Convert To String                       ${result}
    should not contain any          ${result}                               family
    run                             ${Main.cfset} MacFirewall.UnwrapSsl -r
    run                             ${Main.cfset} MacFirewall.HttpSafeSearch -r
