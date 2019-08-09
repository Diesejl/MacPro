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
    Restore MacSpider settings

Dr.Web SpIDer Guard Off
    [Documentation]                 Отключение Spider Guard
    [Tags]                          acceptance

    Restore MacSpider settings

    run                             ${Main.cfset} MacFirewall.Start No
    run                             ${Main.cfset} MacSpider.Start No
    run                             curl -O ${Sample.EICAR}
    sleep  5s
    ${output_qu} =                  run                                 ${Main.ctl} qu
    ${output_th} =                  run                                 ${Main.ctl} th
    log                             ${output_qu}
    log                             ${output_th}
    ${threads} =                    convert to string                   ${output_th}
    should not contain any          ${threads}                          EICAR

    Restore MacSpider settings

SpIDer Guard Suspicious Report
    [Documentation]                 Подозрительное игнорировать
    [Tags]                          acceptance

    Restore MacSpider settings

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.OnSuspicious Report
    run                             curl -O ${Sample.suspicious}
    sleep  5s
    ${output_qu} =                  run                                 ${Main.ctl} qu
    ${output_th} =                  run                                 ${Main.ctl} th
    log                             ${output_qu}
    log                             ${output_th}
    ${threads} =                    convert to string                   ${output_th}
    should not contain any              ${threads}                          suspicious

    Restore MacSpider settings

SpIDer Guard Adware Report
    [Documentation]                 Рекламное игнорировать
    [Tags]                          acceptance

    Restore MacSpider settings

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.OnAdware Report
    run                             curl -O ${Sample.adware}
    sleep  5s
    ${output_qu} =                  run                                 ${Main.ctl} qu
    ${output_th} =                  run                                 ${Main.ctl} th
    log                             ${output_qu}
    log                             ${output_th}
    ${threads} =                    convert to string                   ${output_th}
    should contain any              ${threads}                          adware

    Restore MacSpider settings

SpIDer Guard Dialers Report
    [Documentation]                 Программы дозвона игнорировать
    [Tags]                          acceptance

    Restore MacSpider settings

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.OnDialers Report
    run                             curl -O ${Sample.dialers}
    sleep  5s
    ${output_qu} =                  run  ${Main.ctl} qu
    ${output_th} =                  run  ${Main.ctl} th
    log                             ${output_qu}
    log                             ${output_th}
    ${threads} =                    convert to string                   ${output_th}
    should contain any              ${threads}                          dialers

    Restore MacSpider settings

SpIDer Guard Jokes Report
    [Documentation]                 Программы-шутки игнорировать
    [Tags]                          acceptance

    Restore MacSpider settings

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.OnJokes Report
    run                             curl -O ${Sample.jokes}
    sleep  5s
    ${output_qu} =                  run  ${Main.ctl} qu
    ${output_th} =                  run  ${Main.ctl} th
    log                             ${output_qu}
    log                             ${output_th}
    ${threads} =                    convert to string                   ${output_th}
    should contain any              ${threads}                          jokes

    Restore MacSpider settings

SpIDer Guard Hacktools Report
    [Documentation]                 Программы взлома игнорировать
    [Tags]                          acceptance

    Restore MacSpider settings

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.OnHacktools Report
    run                             curl -O ${Sample.hacktools}
    sleep                           5s
    ${output_qu} =                  run                                 ${Main.ctl} qu
    ${output_th} =                  run                                 ${Main.ctl} th
    log                             ${output_qu}
    log                             ${output_th}
    ${threads} =                    convert to string                   ${output_th}
    should contain any              ${threads}                          hacktools

    Restore MacSpider settings

SpIDer Guard Riskware Report
    [Documentation]                 Потенциально опасное игнорировать
    [Tags]                          acceptance

    Restore MacSpider settings

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.OnRiskware Report
    run                             curl -O ${Sample.riskware}
    sleep                           5s
    ${output_qu} =                  run                                 ${Main.ctl} qu
    ${output_th} =                  run                                 ${Main.ctl} th
    log                             ${output_qu}
    log                             ${output_th}
    ${threads} =                    convert to string                   ${output_th}
    should contain any              ${threads}                          riskware

    Restore MacSpider settings

SpIDer Guard Archives Off
    [Documentation]                 Проверка архивов отключена
    [Tags]                          acceptance

    Restore MacSpider settings

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.ArchiveMaxLevel 0
    run                             curl -O ${Sample.EICAR_ZIP}
    sleep                           5s
    ${output_qu} =                  run                                 ${Main.ctl} qu
    ${output_th} =                  run                                 ${Main.ctl} th
    log                             ${output_qu}
    log                             ${output_th}
    ${threads} =                    convert to string                   ${output_th}
    should not contain any          ${threads}                          eicar_com.zip

    Restore MacSpider settings

SpIDer Guard Email Off
    [Documentation]                 Проверка почтовых файлов отключена
    [Tags]                          acceptance

    Restore MacSpider settings

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacSpider.MailMaxLevel 0
    run                             curl -O ${Sample.email}
    sleep                           5s
    ${output_qu} =                  run                                 ${Main.ctl} qu
    ${output_th} =                  run                                 ${Main.ctl} th
    log                             ${output_qu}
    log                             ${output_th}
    ${threads} =                    convert to string                   ${output_th}
    should not contain any          ${threads}                          eicar_com.zip

    Restore MacSpider settings

[Teardown]
    Restore MacSpider settings