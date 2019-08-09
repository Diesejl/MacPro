*** Settings ***

Library                             RequestsLibrary
Library                             OperatingSystem
Library                             SeleniumLibrary                      run_on_failure=Close browser
Variables                           macProVar.yaml
Resource                            KeyWords.robot

*** Test Cases ***

Dr.Web base Update 1h
    [Documentation]                 Время обновления 1 час
    [Tags]                          acceptance
    Dr.Web base Update              1h

Dr.Web base Update 30m
    [Documentation]                 Время обновления 30 минут
    [Tags]                          acceptance
    Dr.Web base Update              30m

Dr.Web base Update 4h
    [Documentation]                 Время обновления 4 часа
    [Tags]                          acceptance
    Dr.Web base Update              4h

Dr.Web base Update 8h
    [Documentation]                 Время обновления 8 часов
    [Tags]                          acceptance
    Dr.Web base Update              8h

Dr.Web base Update 24h
    [Documentation]                 Время обновления 24 часа
    [Tags]                          acceptance
    Dr.Web base Update              1d

[Teardown]
    run                             ${Main.cfset} Update.UpdateInterval -r