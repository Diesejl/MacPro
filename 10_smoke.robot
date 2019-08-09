*** Settings ***
Library                             RequestsLibrary
Library                             OperatingSystem
Library                             String
Variables                           macProVar.yaml
Resource                            KeyWords.robot

*** Variables ***

${es11}               esconnect mobile-es11.drw:2193 --Key /Users/tester/Desktop/es11.pub --Login macmac --Password qazcde
${es10}               esconnect mobile-es10.drw:2193 --Key /Users/tester/Desktop/es10.pub --Login macmac --Password qazcde
${avd10}              esconnect mobile-avd10.drw:2193 --Key /Users/tester/Desktop/avd10.pub --Login macmac --Password qazcde

*** Test Cases ***

Open Dr.Web GUI
    [Documentation]                 Открытие GUI приложения
    [Tags]                          smoke
    ${code}  ${output} =            run and return rc and output         ${Main.openGui}
    sleep                           3s
    Log                             ${output}
    Should Be Equal As Integers     ${code}                              0

Close Dr.Web GUI
    [Documentation]                 Закрытие GUI приложения
    [Tags]                          smoke
    [Setup]                         run                                  ${Main.openGui}
    sleep                           3s
    ${code}  ${output} =            run and return rc and output         ${Main.closeGui}
    Log                             ${output}
    Should Be Equal As Integers     ${code}                              0

Dr.Web SpIDer Guard On
    [Documentation]                 Включение Spider Guard. Скачивается EICAR Выключен Spider Gate.
    [Tags]                          smoke

    Clear Th/Qu All
    run                             ${Main.cfset} MacFirewall.Start No
    run                             ${Main.cfset} MacSpider.Start Yes
    sleep                           5s
    run                             curl -O ${Sample.EICAR}
    sleep                           5s
    ${output_qu} =                  run                                  ${Main.ctl} qu
    ${output_th} =                  run                                  ${Main.ctl} th
    ${quarantine} =                 convert to string                    ${output_qu}
    should contain any              ${quarantine}                        eicar.com
    Clear Th/Qu All

Dr.Web base Update
    [Documentation]                 Обновление вирусных баз
    [Tags]                          smoke
    [Setup]                         run                                  ${Main.ctl} esdisconnect

    ${update} =                     run                                  ${Main.ctl} up
    ${update} =                     Convert To String                    ${update}
    should contain any              ${update}                            All files are up to date

SpIDer Gate OFF
    [Documentation]                 Отключение SpIDer Gate, открытие ресурса "не рекомендуемый", не должно быть кода 403
    [Tags]                          smoke
    [Setup]                         run                                  ${Main.cfset} MacFirewall.Start -r
    [Teardown]                      run                                  ${Main.cfset} MacFirewall.Start -r

    run                             ${Main.cfset} MacFirewall.Start No
    Create Session                  NotRecommended                       ${Category.notrcm}              verify=${False}
    ${resp} =                       Get Request                          NotRecommended                          /
    Should not Be Equal As Strings  ${resp.status_code}                  403

Es 11 connection
    [Documentation]                 Подключение агента к ES 11 серверу
    [Tags]                          smoke
    [Setup]                         run                                  ${Main.ctl} esdisconnect
    [Teardown]                      run                                  ${Main.ctl} esdisconnect

    ${result} =                     run                                  ${Main.ctl} ${es11}
    sleep                           2s
    ${ap_result} =                  run                                  ${Main.ctl} ap
    ${ap_result} =                  Convert To String                    ${ap_result}
    Should Contain Any              ${ap_result}                         Connected   on-line

Es 10 connection
    [Documentation]                 Подключение агента к ES 10 серверу
    [Tags]                          smoke
    [Setup]                         run                                  ${Main.ctl} esdisconnect
    [Teardown]                      run                                  ${Main.ctl} esdisconnect

    ${result} =                     run                                  ${Main.ctl} ${es10}
    sleep                           2s
    ${ap_result} =                  run                                  ${Main.ctl} ap
    ${ap_result} =                  Convert To String                    ${ap_result}
    Should Contain Any              ${ap_result}                         Connected   on-line

Avd10 connection
    [Documentation]                 Подключение агента к AVD 10 серверу
    [Tags]                          smoke
    [Setup]                         run                                  ${Main.ctl} esdisconnect
    [Teardown]                      run                                  ${Main.ctl} esdisconnect

    ${result} =                     run                                  ${Main.ctl} ${avd10}
    sleep                           2s
    ${ap_result} =                  run                                  ${Main.ctl} ap
    ${ap_result} =                  Convert To String                    ${ap_result}
    Should Contain Any              ${ap_result}                         Connected   on-line
