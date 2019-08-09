*** Settings ***
Library                 RequestsLibrary
Library                 OperatingSystem
Library                 String
Library                 SeleniumLibrary
Variables               macProVar.yaml
Resource                KeyWords.robot

*** Test Cases ***
Restore category settings
    Restore category settings

#Open Dr.Web GUI
#    [Documentation]                 Открытие GUI приложения
#    [Tags]                          smoke
#    ${code}  ${output} =            run and return rc and output    ${mainopenGui}
#    sleep                           3s
#    Log                             ${output}
#    Should Be Equal As Integers     ${code}                         0
#
#Close Dr.Web GUI
#    [Documentation]                 Закрытие GUI приложения
#    [Tags]                          smoke
#    [Setup]                         run                             ${Main.openGui}
#    sleep                           3s
#    ${code}  ${output} =            run and return rc and output    ${Main.closeGui}
#    Log                             ${output}
#    Should Be Equal As Integers     ${code}                         0

#Avd10 connection
#    [Documentation]                 Подключение агента к AVD 10 серверу
#    [Tags]                          smoke
#    [Setup]                         run                             ${Main.ctl} esdisconnect
#    [Teardown]                      run                             ${Main.ctl} esdisconnect
#
#    ${result} =                     run                             ${Main.ctl} ${avd10}
#    sleep                           2s
#    ${ap_result} =                  run                             ${Main.ctl} ap
#    ${ap_result} =                  Convert To String               ${ap_result}
#    Should Contain Any              ${ap_result}                    Connected   on-line



#Dr.Web base Update
#    [Documentation]                 Обновление вирусных баз
#    [Tags]                          smoke
#    [Setup]                         run                             ${Main.ctl} esdisconnect
#    ${update} =                     run                             ${Main.ctl} up
#    ${update} =                     Convert To String               ${update}
#    should contain any              ${update}                       All files are up to date

#Dr.Web SpIDer Guard On
#    [Documentation]                 Включение Spider Guard. Скачивается EICAR Выключен Spider Gate.
#    [Tags]                          smoke
#
#    run                             ${Main.ctl} th --delete all
#    run                             ${Main.ctl} qu --delete all
#    run                             ${Main.cfset} MacFirewall.Start No
#    run                             ${Main.cfset} MacSpider.Start Yes
#    sleep                           5s
#    run                             curl -O ${Sample.EICAR}
#    sleep                           5s
#    ${output_qu} =                  run                             ${Main.ctl} qu
#    ${output_th} =                  run                             ${Main.ctl} th
#    ${quarantine} =                 convert to string               ${output_qu}
#    should contain any              ${quarantine}                   eicar.com
#    Clear Th/Qu All





*** Keywords ***
#[setup]
#    restore category settings
#    run  ${cfset} MacSpider.Start Yes
#    run  ${cfset} MacFirewall.Start Yes
#    sleep  5s
#
#Block FreeEmail Content Off
#    [Documentation]     Блокировка сайтов с электронной почтой отключена
#    [Tags]    acceptance
#    [Teardown]    run  ${cfset} MacFirewall.BlockFreeEmail -r
#    run  ${cfset} MacFirewall.BlockFreeEmail No
#    sleep  1s
#    Check White Url In Browser    ${freeemail}
#    Get White Code And Reason     ${freeemail}

#Check url in browser
#    [Arguments]     ${url_name}     ${reason}
#    Open Browser	${url_name}  	Chrome
#    sleep  2s
#    Page Should Not Contain     ${block}
#    Page Should Not Contain	    ${reason}
#    Page Should Not Contain button  id:return-button
#    Page Should Not Contain Link  Ознакомьтесь с политикой Dr.Web
#    Page Should Not Contain Link  внесите этот адрес в белый список сайтов на своем устройстве
#    Page Should Not Contain Link  сообщите нам об ошибке
#    Close Browser
