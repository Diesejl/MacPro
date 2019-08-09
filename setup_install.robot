*** Settings ***
Library     OperatingSystem
Library     00_betacase.robot

*** Variables ***
${PATH}     /Users/tester/Desktop/drweb32.key
${dirdrweb}     /Library/Application Support/DrWeb/
*** Test Cases ***
Beta case
    Remove Directory  	 ${dirdrweb}     recursive=True
    Copy File	${PATH}	/Library/Application Support/DrWeb/keys/drweb32.key

Root LogLevel Debug
    mac change parametr  Root.DefaultLogLevel    Debug

Root log save
    mac change parametr     Root.Log    /tmp/root.log

Scan log save
    mac change parametr  ScanEngine.Log     /tmp/scan.log

Delete virus bases
    Remove Files    /Library/Application Support/DrWeb