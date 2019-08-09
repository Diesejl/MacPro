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

Block Suspicious Content On
    [Documentation]                 SpiderGate Подозрительное включено
    [Tags]                          acceptance
    [Teardown]                      run                                 ${Main.cfset} MacFirewall.BlockSuspicious -r
    run                             ${Main.cfset} MacFirewall.BlockSuspicious yes
    sleep                           2s
    Check Extra on in browser       ${Main.server}${Extra.suspicious} 	    Обнаружена угроза
    Get code and reason Extra       ${Extra.suspicious}

Block Riskware Content On
    [Documentation]                 SpiderGate Потенциально опасное включено
    [Tags]                          acceptance
    [Teardown]                      run                                 ${Main.cfset} MacFirewall.Blockriskware -r
    run                             ${Main.cfset} MacFirewall.Blockriskware yes
    sleep                           2s
    Check Extra on in browser       ${Main.server}${Extra.riskware} 	        Обнаружена угроза
    Get code and reason Extra       ${Extra.riskware}

Block Dialers Content On
    [Documentation]                 SpiderGate Программы дозвона включено
    [Tags]                          acceptance
    [Teardown]                      run                                 ${Main.cfset} MacFirewall.Blockdialers -r
    run                             ${Main.cfset} MacFirewall.Blockdialers yes
    sleep                           2s
    Check Extra on in browser       ${Main.server}${Extra.dialers}	        Обнаружена угроза
    Get code and reason Extra       ${Extra.dialers}

Block Hacktools Content On
    [Documentation]                 SpiderGate Программы взлома включено
    [Tags]                          acceptance
    [Teardown]                      run                                 ${Main.cfset} MacFirewall.Blockhacktools -r
    run                             ${Main.cfset} MacFirewall.Blockhacktools yes
    sleep                           2s
    Check Extra on in browser       ${Main.server}${Extra.hacktools}	        Обнаружена угроза
    Get code and reason Extra       ${Extra.hacktools}

Block Adware Content On
    [Documentation]                 SpiderGate Рекламные программы включено
    [Tags]                          acceptance
    [Teardown]                      run                                 ${Main.cfset} MacFirewall.Blockadware -r
    run                             ${Main.cfset} MacFirewall.Blockadware yes
    sleep                           2s
    Check Extra on in browser       ${Main.server}${Extra.adware}	        Обнаружена угроза
    Get code and reason Extra       ${Extra.adware}

Block Jokes Content On
    [Documentation]                 SpiderGate Программы-шутки включено
    [Tags]                          acceptance
    [Teardown]                      run  ${Main.cfset} MacFirewall.BlockJokes -r
    run                             ${Main.cfset} MacFirewall.BlockJokes yes
    sleep                           2s
    Check Extra on in browser       ${Main.server}${Extra.jokes}	Обнаружена угроза
    Get code and reason Extra       ${Extra.jokes}
