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

Dr.Web SpIDer Guard On
    [Documentation]                 Включение Spider Guard
    [Tags]                          acceptance

    Clear Th/Qu All

    run                             ${Main.cfset} MacSpider.Start Yes
    sleep                           5s
    run                             curl -O ${Sample.EICAR}
    sleep  5s
    ${output_qu} =                  run                                  ${Main.ctl} qu
    ${output_th} =                  run                                  ${Main.ctl} th
    log                             ${output_qu}
    log                             ${output_th}
    ${quarantine} =                 convert to string                    ${output_qu}
    should contain any              ${quarantine}                        eicar.com

    Clear Th/Qu All

SpIDer Guard Incurable Quarantine
    [Documentation]                 Неизлечимое в карантин
    [Tags]                          acceptance

    Clear Th/Qu All

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.OnIncurable Quarantine
    run                             curl -O ${Sample.incurable}
    sleep                           5s
    ${output_qu} =                  run                                 ${Main.ctl} qu
    ${output_th} =                  run                                 ${Main.ctl} th
    log                             ${output_qu}
    log                             ${output_th}
    ${quarantine} =                 convert to string                   ${output_qu}
    should contain any              ${quarantine}                       incurable

    Clear Th/Qu All

SpIDer Guard Suspicious Quarantine
    [Documentation]                 Подозрительное в карантин
    [Tags]                          acceptance

    Clear Th/Qu All

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.OnSuspicious Quarantine
    run                             curl -O ${Sample.suspicious}
    sleep                           5s
    ${output_qu} =                  run                                 ${Main.ctl} qu
    ${output_th} =                  run                                 ${Main.ctl} th
    log                             ${output_qu}
    log                             ${output_th}
    ${quarantine} =                 convert to string                   ${output_qu}
    should contain any              ${quarantine}                       suspicious

    Clear Th/Qu All

SpIDer Guard Adware Quarantine
    [Documentation]                 Рекламное в карантин
    [Tags]                          acceptance

    Clear Th/Qu All

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.OnAdware Quarantine
    run                             curl -O ${Sample.adware}
    sleep                           5s
    ${output_qu} =                  run                                 ${Main.ctl} qu
    ${output_th} =                  run                                 ${Main.ctl} th
    log                             ${output_qu}
    log                             ${output_th}
    ${quarantine} =                 convert to string                   ${output_qu}
    should contain any              ${quarantine}                       adware

    Clear Th/Qu All

SpIDer Guard Dialers Quarantine
    [Documentation]                 Программы дозвона в карантин
    [Tags]                          acceptance

    Clear Th/Qu All

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.OnDialers Quarantine
    run                             curl -O ${Sample.dialers}
    sleep                           5s
    ${output_qu} =                  run  ${Main.ctl} qu
    ${output_th} =                  run  ${Main.ctl} th
    log                             ${output_qu}
    log                             ${output_th}
    ${quarantine} =                 convert to string                   ${output_qu}
    should contain any              ${quarantine}                       dialers

    Clear Th/Qu All

SpIDer Guard Jokes Quarantine
    [Documentation]                 Программы-шутки в карантин
    [Tags]                          acceptance

    Clear Th/Qu All

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.OnJokes Quarantine
    run                             curl -O ${Sample.jokes}
    sleep                           5s
    ${output_qu} =                  run  ${Main.ctl} qu
    ${output_th} =                  run  ${Main.ctl} th
    log                             ${output_qu}
    log                             ${output_th}
    ${quarantine} =                 convert to string                   ${output_qu}
    should contain any              ${quarantine}                       jokes

    Clear Th/Qu All

SpIDer Guard Hacktools Quarantine
    [Documentation]                 Программы взлома в карантин
    [Tags]                          acceptance

    Clear Th/Qu All

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.OnHacktools Quarantine
    run                             curl -O ${Sample.hacktools}
    sleep                           5s
    ${output_qu} =                  run  ${Main.ctl} qu
    ${output_th} =                  run  ${Main.ctl} th
    log                             ${output_qu}
    log                             ${output_th}
    ${quarantine} =                 convert to string                   ${output_qu}
    should contain any              ${quarantine}                       hacktools

    Clear Th/Qu All

SpIDer Guard Riskware Quarantine
    [Documentation]                 Потенциально опасное в карантин
    [Tags]                          acceptance

    Clear Th/Qu All

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.OnRiskware Quarantine
    run                             curl -O ${Sample.riskware}
    sleep                           5s
    ${output_qu} =                  run                                 ${Main.ctl} qu
    ${output_th} =                  run                                 ${Main.ctl} th
    log                             ${output_qu}
    log                             ${output_th}
    ${quarantine} =                 convert to string                   ${output_qu}
    should contain any              ${quarantine}                       riskware

    Clear Th/Qu All

SpIDer Guard KnownVirus Quarantine
    [Documentation]                 Инфицированное в карантин
    [Tags]                          acceptance

    Clear Th/Qu All

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.OnKnownVirus Quarantine
    run                             curl -O ${Sample.curable}
    sleep                           5s
    ${output_qu} =                  run                                 ${Main.ctl} qu
    ${output_th} =                  run                                 ${Main.ctl} th
    log                             ${output_qu}
    log                             ${output_th}
    ${quarantine} =                 convert to string                   ${output_qu}
    should contain any              ${quarantine}                       curable

    Clear Th/Qu All

SpIDer Guard Archives On
    [Documentation]                 Проверка архивов включена
    [Tags]                          acceptance

    Clear Th/Qu All

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.ArchiveMaxLevel 8
    run                             curl -O ${Sample.EICAR_ZIP}
    sleep                           5s
    ${output_qu} =                  run                                 ${Main.ctl} qu
    ${output_th} =                  run                                 ${Main.ctl} th
    log                             ${output_qu}
    log                             ${output_th}
    ${quarantine} =                 convert to string                   ${output_qu}
    should contain any              ${quarantine}                       eicar_com.zip

    Clear Th/Qu All

SpIDer Guard Email On
    [Documentation]                 Проверка почтовых файлов включена
    [Tags]                          acceptance

    Clear Th/Qu All

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.MailMaxLevel 8
    run                             curl -O ${Sample.email}
    sleep                           5s
    ${output_qu} =                  run                                 ${Main.ctl} qu
    ${output_th} =                  run                                 ${Main.ctl} th
    log                             ${output_qu}
    log                             ${output_th}
    ${quarantine} =                 convert to string                   ${output_qu}
    should contain any              ${quarantine}                       eicar.eml

    Clear Th/Qu All

[Teardown]
    Restore MacSpider settings
