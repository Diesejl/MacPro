# http://robotframework.org/robotframework/#standard-libraries

*** Settings ***
Library     OperatingSystem
*** Variables ***
${dmg}      /Users/tester/Desktop/drweb-pro-1111-osx.dmg
*** Test Cases ***
Mount dmg
    run  hdiutil attach ${dmg}

Install app
    run  cp -R "/Volumes/Dr.Web for macOS/Dr.Web for macOS.app" /Applications

Unmount dmg
    run  hdiutil detach /Volumes/Dr.Web\\ for\\ macOS/