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
    sleep                           5s

Black list one address
    [Documentation]                 Добавление одного адреса в черный список
    [Tags]                          acceptance
    [Teardown]                      run                                 ${Main.cfset} MacFirewall.Blacklist -r

    ${resp} =                       run                                 ${Main.cfset} -a MacFirewall.Blacklist "{*, \\"${BW.socialnet}\\", *}"

    Get Black code and reason       ${BW.socialnet}
    Check Black Url In Browser      ${BW.socialnet}

Black list addresses
    [Documentation]                 Добавление нескольких адресов в черный список
    [Tags]                          acceptance
    [Teardown]                      run                                 ${Main.cfset} MacFirewall.Blacklist -r

    ${resp1} =                      run                                 ${Main.cfset} -a MacFirewall.Blacklist "{*, \\"${BW.socialnet}\\", *}"
    ${resp2} =                      run                                 ${Main.cfset} -a MacFirewall.Blacklist "{*, \\"${BW.weapons}\\", *}"
    ${resp3} =                      run                                 ${Main.cfset} -a MacFirewall.Blacklist "{*, \\"${BW.socialnet2}\\", *}"

    Get black code and reason                                           ${BW.socialnet}
    Check Black Url In Browser                                          ${BW.socialnet}

    Get black code and reason                                           ${BW.weapons}
    Check Black Url In Browser                                          ${BW.weapons}

    Get black code and reason                                           ${BW.socialnet2}
    Check Black Url In Browser                                          ${BW.socialnet2}

White list Adult
    [Documentation]                 Добавление адреса из категории для взрослых в белый список
    [Tags]                          acceptance
    [Teardown]                      Restore category settings

    run                             ${Main.cfset} MacFirewall.BlockAdultContent Yes
    run                             ${Main.cfset} -a MacFirewall.Whitelist "{*, \\"${BW.adult}\\", *}"

    Get White code and reason       ${BW.adult}
    Check White Url In Browser      ${BW.adult}

White list Social
    [Documentation]                 Добавление адреса из категории для соц. сетей в белый список
    [Tags]                          acceptance
    [Teardown]                      restore category settings

    run                             ${Main.cfset} MacFirewall.BlockSocialNetworks Yes
    run                             ${Main.cfset} -a MacFirewall.Whitelist "{*, \\"${BW.socialnet}\\", *}"

    Get White code and reason       ${BW.socialnet}
    Check White Url In Browser      ${BW.socialnet}

White list Weapons
    [Documentation]                 Добавление адреса из категории оружие в белый список
    [Tags]                          acceptance
    [Teardown]                      restore category settings

    run                             ${Main.cfset} MacFirewall.BlockWeapons Yes
    run                             ${Main.cfset} -a MacFirewall.Whitelist "{*, \\"${BW.weapons}\\", *}"

    Get White code and reason       ${BW.weapons}
    Check White Url In Browser      ${BW.weapons}

White list Violence
    [Documentation]                 Добавление адреса из категории насилие в белый список
    [Tags]                          acceptance
    [Teardown]                      restore category settings

    run                             ${Main.cfset} MacFirewall.BlockViolence Yes
    run                             ${Main.cfset} -a MacFirewall.Whitelist "{*, \\"${BW.violence}\\", *}"

    Get White code and reason       ${BW.violence}
    Check White Url In Browser      ${BW.violence}

White list Gambling
    [Documentation]                 Добавление адреса из категории азартные игры в белый список
    [Tags]                          acceptance
    [Teardown]                      restore category settings

    run                             ${Main.cfset} MacFirewall.BlockGambling Yes
    run                             ${Main.cfset} -a MacFirewall.Whitelist "{*, \\"${BW.gambling}\\", *}"

    Get White code and reason       ${BW.gambling}
    Check White Url In Browser      ${BW.gambling}

White list Drugs
    [Documentation]                 Добавление адреса из категории наркотики в белый список
    [Tags]                          acceptance
    [Teardown]                      restore category settings

    run                             ${Main.cfset} MacFirewall.BlockDrugs Yes
    run                             ${Main.cfset} -a MacFirewall.Whitelist "{*, \\"${BW.drugs}\\", *}"

    Get White code and reason       ${BW.drugs}
    Check White Url In Browser      ${BW.drugs}

White list ObsceneLanguage
    [Documentation]                 Добавление адреса из категории нецензурная лексика в белый список
    [Tags]                          acceptance
    [Teardown]                      restore category settings

    run                             ${Main.cfset} MacFirewall.BlockObsceneLanguage Yes
    run                             ${Main.cfset} -a MacFirewall.Whitelist "{*, \\"${BW.obslang}\\", *}"

    Get White code and reason       ${BW.obslang}
    Check White Url In Browser      ${BW.obslang}

White list Chats
    [Documentation]                 Добавление адреса из категории чаты в белый список
    [Tags]                          acceptance
    [Teardown]                      restore category settings

    run                             ${Main.cfset} MacFirewall.BlockChats Yes
    run                             ${Main.cfset} -a MacFirewall.Whitelist "{*, \\"${BW.chats}\\", *}"

    Get White code and reason       ${BW.chats}
    Check White Url In Browser      ${BW.chats}

White list Terrorism
    [Documentation]                 Добавление адреса из категории терроризм в белый список
    [Tags]                          acceptance
    [Teardown]                      restore category settings

    run                             ${Main.cfset} MacFirewall.BlockTerrorism Yes
    run                             ${Main.cfset} -a MacFirewall.Whitelist "{*, \\"${BW.terrorism}\\", *}"

    Get White code and reason       ${BW.terrorism}
    Check White Url In Browser      ${BW.terrorism}

White list Email
    [Documentation]                 Добавление адреса из категории электронная почта в белый список
    [Tags]                          acceptance
    [Teardown]                      restore category settings

    run                             ${Main.cfset} MacFirewall.BlockFreeEmail Yes
    run                             ${Main.cfset} -a MacFirewall.Whitelist "{*, \\"${BW.freeemail}\\", *}"

    Get White code and reason       ${BW.freeemail}
    Check White Url In Browser      ${BW.freeemail}

White list CopyRight
    [Documentation]                 Добавление адреса из категории по обращению правообладателя в белый список
    [Tags]                          acceptance
    [Teardown]                      restore category settings

    run                             ${Main.cfset} MacFirewall.BlockDueToCopyrightNotice No
    run                             ${Main.cfset} MacFirewall.BlockNotRecommended No
    run                             ${Main.cfset} -a MacFirewall.Whitelist "{*, \\"${BW.copyright}\\", *}"

    Get White code and reason       ${BW.copyright}
    Check White Url In Browser      ${BW.copyright}

Black list delete address
    [Documentation]                 Удаление адреса из черного списка
    [Tags]                          acceptance
    [Setup]                         run                                 ${Main.cfset} -a MacFirewall.Blacklist "{*, \\"${BW.socialnet}\\", *}"
    [Teardown]                      restore category settings
    sleep                           2s

    Get Black Code And Reason       ${BW.socialnet}

    ${resp} =                       run                                 ${Main.cfset} -e MacFirewall.blacklist "{*, \\"${BW.socialnet}\\", *}"

    Get White code and reason       ${BW.socialnet}
    Check White Url In Browser      ${BW.socialnet}

White list delete address
    [Documentation]                 Удаление адреса из белого списка
    [Tags]                          acceptance
    [Teardown]                      restore category settings

    run                             ${Main.cfset} MacFirewall.BlockAdultContent Yes
    run                             ${Main.cfset} -a MacFirewall.Whitelist "{*, \\"${BW.adult}\\", *}"

    Get White code and reason       ${BW.adult}
    Check White Url In Browser      ${BW.adult}

    run                             ${Main.cfset} -e MacFirewall.Whitelist "{*, \\"${BW.adult}\\", *}"
    sleep                           2s
    Get Black code and reason       ${BW.adult}
#    Check Black Url In Browser     ${BW.adult}
