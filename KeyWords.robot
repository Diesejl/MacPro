
*** Settings ***
Library                             RequestsLibrary
Library                             OperatingSystem
Library                             String
Library                             SeleniumLibrary                      run_on_failure=Close browser
Variables                           macProVar.yaml

*** Keywords ***
Restore category settings
    [Documentation]  Восстановление настроек блокировок по категориям и черного/белого списка

    run                             ${Main.cfset} MacFirewall.BlockAdultContent -r
    run                             ${Main.cfset} MacFirewall.BlockViolence -r
    run                             ${Main.cfset} MacFirewall.BlockWeapons -r
    run                             ${Main.cfset} MacFirewall.BlockGambling -r
    run                             ${Main.cfset} MacFirewall.BlockDrugs -r
    run                             ${Main.cfset} MacFirewall.BlockObsceneLanguage -r
    run                             ${Main.cfset} MacFirewall.BlockChats -r
    run                             ${Main.cfset} MacFirewall.BlockTerrorism -r
    run                             ${Main.cfset} MacFirewall.BlockFreeEmail -r
    run                             ${Main.cfset} MacFirewall.BlockSocialNetworks -r
    run                             ${Main.cfset} MacFirewall.BlockNotRecommended -r
    run                             ${Main.cfset} MacFirewall.BlockDueToCopyrightNotice -r
    run                             ${Main.cfset} MacFirewall.Blacklist -r
    run                             ${Main.cfset} MacFirewall.Whitelist -r

Restore Extra settings

    run                             ${Main.cfset} MacFirewall.BlockSuspicious -r
    run                             ${Main.cfset} MacFirewall.Blockriskware -r
    run                             ${Main.cfset} MacFirewall.Blockdialers -r
    run                             ${Main.cfset} MacFirewall.Blockhacktools -r
    run                             ${Main.cfset} MacFirewall.Blockadware -r
    run                             ${Main.cfset} MacFirewall.BlockJokes -r
    run                             ${Main.cfset} MacFirewall.Blacklist -r
    run                             ${Main.cfset} MacFirewall.Whitelist -r

Restore MacSpider settings

    run                             ${Main.cfset} MacSpider.OnSuspicious -r
    run                             ${Main.cfset} MacSpider.OnAdware -r
    run                             ${Main.cfset} MacSpider.OnDialers -r
    run                             ${Main.cfset} MacSpider.OnJokes -r
    run                             ${Main.cfset} MacSpider.OnHacktools -r
    run                             ${Main.cfset} MacSpider.OnRiskware -r
    run                             ${Main.cfset} MacSpider.ArchiveMaxLevel -r
    run                             ${Main.cfset} MacSpider.MailMaxLevel -r
    run                             ${Main.cfset} MacSpider.OnKnownVirus -r
    run                             ${Main.cfset} MacSpider.OnIncurable -r

Clear Th/Qu All
    [Documentation]  Удаление всех файлов из угроз и файлов

    run                             ${Main.ctl} th --delete all
    run                             ${Main.ctl} qu --delete all

Check White url in browser

    [Arguments]                     ${url_name}
    Open Browser	                http://${url_name}  	            Chrome
    sleep                           2s
    Page Should Not Contain         URL заблокирован SpIDer Gate
    Page Should Not Contain	        Черный список
    Page Should Not Contain button  id:return-button
    Page Should Not Contain Link    Подробнее о том, как отключить блокировку URL
    Close Browser

Check Black url in browser

    [Arguments]                     ${url_name}
    Open Browser	                http://${url_name}  	             Chrome
    sleep  2s
    Page Should Contain             URL заблокирован SpIDer Gate
    Page Should Contain	            Черный список
    Page Should Contain button      id:return-button
    Page Should Contain Link        Подробнее о том, как отключить блокировку URL
    Close Browser

Get black code and reason

    [Arguments]                     ${url_name}
    Create Session                  url                                 http://${url_name}      verify=${False}
    ${resp} =                       Get Request                         url                     /
    Should Be Equal As Strings      ${resp.status_code}                 403
    Should Be Equal As Strings      ${resp.reason}                      Blocked by SpIDer Gate

Get white code and reason

    [Arguments]                     ${url_name}
    Create Session                  url                                 http://${url_name}      verify=${False}
    ${resp} =                       Get Request                         url                     /
    Should Not Be Equal As Strings  ${resp.status_code}                 403
    Should Not Be Equal As Strings  ${resp.reason}                      Blocked by SpIDer Gate

Check url in browser
    [Arguments]                     ${url_name}                         ${reason}
    Open Browser	                ${url_name}  	                    Chrome
    sleep                           2s
    Page Should Contain             ${Text.block}
    Page Should Contain	            ${reason}
    Page Should Contain button      id:return-button
    Page Should Contain Link        Ознакомьтесь с политикой Dr.Web
    Page Should Contain Link        внесите этот адрес в белый список сайтов на своем устройстве
    Page Should Contain Link        сообщите нам об ошибке
    Close Browser

Check url in browser Not
    [Arguments]                     ${url_name}
    Open Browser	                ${url_name}  	                     Chrome
    sleep                           2s
    Page Should Not Contain         ${Text.block}
    Page Should Not Contain button  id:return-button
    Page Should Not Contain Link    Ознакомьтесь с политикой Dr.Web
    Page Should Not Contain Link    внесите этот адрес в белый список сайтов на своем устройстве
    Page Should Not Contain Link    сообщите нам об ошибке
    Close Browser


Get code and reason
    [Arguments]                     ${url_name}
    Create Session                  url                                 ${url_name}                 verify=${False}
    ${resp} =                       Get Request                         url                         /
    Should Be Equal As Strings      ${resp.status_code}                 403
    Should Be Equal As Strings      ${resp.reason}                      Blocked by SpIDer Gate

Get code and reason Extra
    [Arguments]                     ${url_name}
    Create Session                  url                                 ${Main.server}              verify=${False}
    ${resp} =                       Get Request                         url                         ${url_name}
    Should Be Equal As Strings      ${resp.status_code}                 403
    Should Be Equal As Strings      ${resp.reason}                      Blocked by SpIDer Gate

Get code and reason Extra Off
    [Arguments]                     ${url_name}
    Create Session                  url                                 ${Main.server}              verify=${False}
    ${resp} =                       Get Request                         url                         ${url_name}
    Should Be Equal As Strings      ${resp.status_code}                 200
    Should Be Equal As Strings      ${resp.reason}                      OK

Get code and reason Not
    [Arguments]                     ${url_name}
    Create Session                  url                                 ${url_name}                 verify=${False}
    ${resp} =                       Get Request                         url                         /
    Should Not Be Equal As Strings  ${resp.status_code}                 403
    Should Not Be Equal As Strings  ${resp.reason}                      Blocked by SpIDer Gate

Check Extra on in browser
    [Arguments]                     ${url_name}                         ${reason}
    Open Browser	                ${url_name}  	                    Chrome
    sleep                           2s
    Page Should Contain             URL заблокирован SpIDer Gate
    Page Should Contain	            ${reason}
    Page Should Contain button      id:return-button
    Page Should Contain Link        сообщите нам об ошибке
    Close Browser

Dr.Web base Update
    [Documentation]                 Выбор времени обновления баз
    [Arguments]                     ${Update_time}
    run                             ${Main.cfset} Update.UpdateInterval ${Update_time}
    ${update} =                     run                                 ${Main.cfshow} Update.UpdateInterval
    log                             ${update}
    should contain any              ${update}                           ${Update_time}
    sleep                           3s