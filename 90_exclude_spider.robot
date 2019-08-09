*** Settings ***

Library                             RequestsLibrary
Library                             OperatingSystem
Library                             SeleniumLibrary                      run_on_failure=Close browser
Variables                           macProVar.yaml
Resource                            KeyWords.robot

*** Test Cases ***

Dr.Web SpIDer Exclude On
    [Documentation]                 Проверка пути исключения включена
    [Tags]                          acceptance
    [Setup]                         run                                 ${Main.cfset} MacSpider.ExcludedPath -r
    Clear Th/Qu All

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacFirewall.Start No

    run                             ${Main.cfset} -a MacSpider.ExcludedPath /private/tmp
    run                             curl -Lk ${Sample.EICAR} -o /private/tmp/eicar.com
    sleep                           10s
    File Should Exist               /private/tmp/eicar.com
    ${output_qu} =                  run                                 ${Main.ctl} qu
    ${quarantine} =                 convert to string                   ${output_qu}
    should not contain any          ${quarantine}                       eicar.com

    Clear Th/Qu All
    [Teardown]                      run                                 ${Main.cfset} MacSpider.ExcludedPath -r

Dr.Web SpIDer Exclude Off
    [Documentation]                 Удаление пути исключения с угрозой
    [Tags]                          acceptance
    [Setup]                         run                                 ${Main.cfset} -a MacSpider.ExcludedPath /private/tmp
    Clear Th/Qu All

    run                             ${Main.cfset} MacSpider.Start Yes
    run                             ${Main.cfset} MacFirewall.Start No

    run                             ${Main.cfset} -e MacSpider.ExcludedPath /private/tmp
    run                             curl -Lk ${Sample.EICAR} -o /private/tmp/eicar.com
    sleep                           10s
    ${output_qu} =                  run                                 ${Main.ctl} qu
    ${quarantine} =                 convert to string                   ${output_qu}
    should contain any              ${quarantine}                       eicar.com

    Clear Th/Qu All
    [Teardown]                      run                                 ${Main.cfset} MacSpider.ExcludedPath -r
