*** Settings ***

Library                             RequestsLibrary
Library                             OperatingSystem
Library                             SeleniumLibrary                      run_on_failure=Close browser
Variables                           macProVar.yaml
Resource                            KeyWords.robot

*** Test Cases ***

[setup]
    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacFirewall.Start Yes
    Restore Extra settings
    sleep                           5s

Block Suspicious Content Off
    [Documentation]                 SpiderGate Подозрительное отключено
    [Tags]                          acceptance
    [Teardown]                      run                                 ${Main.cfset} MacFirewall.BlockSuspicious -r
    run                             ${Main.cfset} MacFirewall.BlockSuspicious No
    sleep                           2s
    Get code and reason Extra Off   ${Extra.suspicious}

Block Riskware Content Off
    [Documentation]                 SpiderGate Потенциально опасное отключено
    [Tags]                          acceptance
    [Teardown]                      run                                 ${Main.cfset} MacFirewall.Blockriskware -r
    run                             ${Main.cfset} MacFirewall.Blockriskware No
    sleep  2s
    Get code and reason Extra Off   ${Extra.riskware}

Block Dialers Content Off
    [Documentation]                 SpiderGate Программы дозвона отключено
    [Tags]                          acceptance
    [Teardown]                      run                                 ${Main.cfset} MacFirewall.Blockdialers -r
    run                             ${Main.cfset} MacFirewall.Blockdialers No
    sleep                           2s
    Get code and reason Extra Off   ${Extra.dialers}

Block Hacktools Content Off
    [Documentation]                 SpiderGate Программы взлома отключено
    [Tags]                          acceptance
    [Teardown]                      run                                 ${Main.cfset} MacFirewall.Blockhacktools -r
    run                             ${Main.cfset} MacFirewall.Blockhacktools No
    sleep                           2s
    Get code and reason Extra Off   ${Extra.hacktools}

Block Adware Content Off
    [Documentation]                 SpiderGate Рекламные продукты отключено
    [Tags]                          acceptance
    [Teardown]                      run                                 ${Main.cfset} MacFirewall.Blockadware -r
    run                             ${Main.cfset} MacFirewall.Blockadware No
    sleep                           2s
    Get code and reason Extra Off   ${Extra.adware}

Block Jokes Content Off
    [Documentation]                 SpiderGate Программы-шутки отключено
    [Tags]                          acceptance
    [Teardown]                      run                                 ${Main.cfset} MacFirewall.BlockJokes -r
    run                             ${Main.cfset} MacFirewall.BlockJokes No
    sleep                           2s
    Get code and reason Extra Off   ${Extra.jokes}
