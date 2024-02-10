*** Settings ***

Library    SeleniumLibrary

Test Setup    Run Keywords
...           Open Browser    url=${URL}    browser=${BROWSER}    AND
...           Maximize Browser Window

Test Teardown    Close Browser

*** Variables ***
### Browser ###

${BROWSER}    chrome
${URL}        http://sistemas.t2mlab.com:3006/

### Usarios ###

${USUARIO_VALIDO}        BLCarvalho
${GESTOR_VALIDO}         SIFigueiredo
${USUARIO_INVALIDO}      Invalido
${SENHA}                 123

### Pagina Login ###

&{LOGIN_PAGE}
...    EmailInput=xpath://input[@aria-label='Email']
...    SenhaInput=xpath://input[@aria-label='Senha']
...    BotãoLogin=xpath://button[@role='button']
...    BotãoCompetencia=//div[@class='container']/div[@class='row']/div[.='SCSistema de Competência']
...    MensagemErro=xpath://div[@class='Toastify__toast Toastify__toast-theme--colored Toastify__toast--error Toastify__toast--close-on-click']

*** Keywords ***

Realizar Login com ${usuario} e ${senha}
    Input Text        ${LOGIN_PAGE.EmailInput}    ${usuario}
    Input Text        ${LOGIN_PAGE.SenhaInput}    ${senha}
    Click Element     ${LOGIN_PAGE.BotãoLogin}

Verificação de login
    Sleep    1s
    Click Element     ${LOGIN_PAGE.BotãoCompetencia}
    Sleep    1s
    ${url}=    Get Location
    Should Contain    ${url}    /home

Verificação de nao login
    Wait Until Element Is Visible    ${LOGIN_PAGE.MensagemErro}

*** Test Cases ***

TC 01 Fazer Login com usuario valido
    [Tags]    FLUXO-POSITIVO01
    Realizar Login com ${USUARIO_VALIDO} e ${SENHA}
    Verificação de login

TC 02 Fazer Login com gestor valido
    [Tags]    FLUXO-POSITIVO02
    Realizar Login com ${GESTOR_VALIDO} e ${SENHA}
    Verificação de login

TC 03 Fazer Login com usuario invalido
    [Tags]    FLUXO-NEGATIVO03
    Realizar Login com ${USUARIO_INVALIDO} e ${SENHA}
    Verificação de nao login