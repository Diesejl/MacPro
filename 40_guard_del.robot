*** Settings ***
Library                             RequestsLibrary
Library                             OperatingSystem
Library                             SeleniumLibrary                      run_on_failure=Close browser
Variables                           macProVar.yaml
Resource                            KeyWords.robot

*** Test Cases ***

[setup]
    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacFirewall.Start No
    Clear Th/Qu All

SpIDer Guard Incurable Delete
    [Documentation]                 Неизлечимое удаление
    [Tags]                          acceptance

    Clear Th/Qu All

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.OnIncurable Delete
    run                             curl -O ${Sample.incurable}
    sleep                           5s
    ${output_qu} =                  run                                 ${Main.cfshow} qu
    ${output_th} =                  run                                 ${Main.cfshow} th
    log                             ${output_qu}
    log                             ${output_th}
    ${quarantine} =                 convert to string                   ${output_qu}
    should not contain any          ${quarantine}                       incurable

    Clear Th/Qu All


SpIDer Guard Suspicious Delete
    [Documentation]                 Подозрительное удалять
    [Tags]                          acceptance

    Clear Th/Qu All

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.OnSuspicious delete
    run                             curl -O ${Sample.suspicious}
    sleep  5s
    ${output_qu} =                  run                                 ${Main.cfshow} qu
    ${output_th} =                  run                                 ${Main.cfshow} th
    log                             ${output_qu}
    log                             ${output_th}
    ${quarantine} =                 convert to string                   ${output_qu}
    should not contain any          ${quarantine}                       suspicious

    Clear Th/Qu All

SpIDer Guard Adware Delete
    [Documentation]                 Рекламное удалять
    [Tags]                          acceptance

    Clear Th/Qu All

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.OnAdware delete
    run                             curl -O ${Sample.adware}
    sleep                           5s
    ${output_qu} =                  run                                 ${Main.cfshow} qu
    ${output_th} =                  run                                 ${Main.cfshow} th
    log                             ${output_qu}
    log                             ${output_th}
    ${quarantine} =                 convert to string                   ${output_qu}
    should not contain any          ${quarantine}                       adware

    Clear Th/Qu All

SpIDer Guard Dialers Delete
    [Documentation]                 Программы дозвона удалять
    [Tags]                          acceptance

    Clear Th/Qu All

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.OnDialers Delete
    run                             curl -O ${Sample.dialers}
    sleep                           5s
    ${output_qu} =                  run                                 ${Main.ctl} qu
    ${output_th} =                  run                                 ${Main.ctl} th
    log                             ${output_qu}
    log                             ${output_th}
    ${quarantine} =                 convert to string                   ${output_qu}
    should not contain any          ${quarantine}                       dialers

    Clear Th/Qu All

SpIDer Guard Jokes Delete
    [Documentation]                 Программы-шутки игнорировать
    [Tags]                          acceptance

    Clear Th/Qu All

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.OnJokes Delete
    run                             curl -O ${Sample.jokes}
    sleep                           5s
    ${output_qu} =                  run                                 ${Main.cfshow} qu
    ${output_th} =                  run                                 ${Main.cfshow} th
    log                             ${output_qu}
    log                             ${output_th}
    ${quarantine} =                 convert to string                   ${output_qu}
    should not contain any          ${quarantine}                       jokes

    Clear Th/Qu All

SpIDer Guard Hacktools Delete
    [Documentation]                 Программы взлома удалять
    [Tags]                          acceptance

    Clear Th/Qu All

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.OnHacktools Delete
    run                             curl -O ${Sample.hacktools}
    sleep                           5s
    ${output_qu} =                  run                                 ${Main.cfshow} qu
    ${output_th} =                  run                                 ${Main.cfshow} th
    log                             ${output_qu}
    log                             ${output_th}
    ${quarantine} =                 convert to string                   ${output_qu}
    should not contain any          ${quarantine}                       hacktools

    Clear Th/Qu All

SpIDer Guard Riskware Delete
    [Documentation]                 Потенциально опасное удалять
    [Tags]                          acceptance

    Clear Th/Qu All

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.OnRiskware Delete
    run                             curl -O ${Sample.riskware}
    sleep                           5s
    ${output_qu} =                  run                                 ${Main.cfshow} qu
    ${output_th} =                  run                                 ${Main.cfshow} th
    log                             ${output_qu}
    log                             ${output_th}
    ${quarantine} =                 convert to string                   ${output_qu}
    should not contain any          ${quarantine}                       riskware

    Clear Th/Qu All

SpIDer Guard KnownVirus Delete
    [Documentation]                 Инфицированное удалять
    [Tags]                          acceptance
    Clear Th/Qu All

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.OnKnownVirus Delete
    run                             curl -O ${Sample.curable}
    sleep                           5s
    ${output_qu} =                  run                                 ${Main.cfshow} qu
    ${output_th} =                  run                                 ${Main.cfshow} th
    log                             ${output_qu}
    log                             ${output_th}
    ${quarantine} =                 convert to string                   ${output_qu}
    should not contain any          ${quarantine}                       curable

    Clear Th/Qu All

[Teardown]
    Restore MacSpider settings
    Clear Th/Qu All