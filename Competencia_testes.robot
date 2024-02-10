*** Settings ***

Library    SeleniumLibrary
Library    DateTime

Test Setup    Run Keywords
...           Open Browser    url=${URL}    browser=${BROWSER}    AND
...           Maximize Browser Window

Test Teardown    Close Browser

*** Variables ***
### Browser ###

${BROWSER}    chrome
${URL}        http://sistemas.t2mlab.com:3006/

### Usarios ###

${GESTOR_VALIDO}         SIFigueiredo
${SENHA}                 123

### Nome Teste e Descrição ###

${NOMETESTE}    Teste
${NOMEDESCRICAO}    Descrição
${NOMETESTEREP}    TesteAuto1234
${NOMEDESCRICAOREP}    DescriçãoAuto1234

### Pagina Login ###

&{LOGIN_PAGE}
...    EmailInput=xpath://input[@aria-label='Email']
...    SenhaInput=xpath://input[@aria-label='Senha']
...    BotãoLogin=xpath://button[@role='button']
...    BotãoCompetencia=//div[@class='container']/div[@class='row']/div[.='SCSistema de Competência']
...    MensagemErro=xpath://div[@class='Toastify__toast Toastify__toast-theme--colored Toastify__toast--error Toastify__toast--close-on-click']

*** Keywords ***

Realizar Login
    Input Text        ${LOGIN_PAGE.EmailInput}    ${GESTOR_VALIDO}
    Input Text        ${LOGIN_PAGE.SenhaInput}    ${SENHA}
    Click Element     ${LOGIN_PAGE.BotãoLogin}
    Sleep    1s
    Click Element     ${LOGIN_PAGE.BotãoCompetencia}

Gerar nome do teste
    ${data}    Get Current Date    result_format=%d/%m/%Y %H:%M:%S
    ${NOMETESTE}    Set Variable    Teste ${data}
    ${NOMEDESCRICAO}    Set Variable    Descrição ${data}
    Set Test Variable    ${NOMETESTE}
    Set Test Variable    ${NOMEDESCRICAO}

Cadastrar competencia
    Realizar Login
    
    Click Element    //button[.='Competência']
    
    Wait Until Element Is Visible    //button[.='Cadastrar Competência']
    Click Element    //button[.='Cadastrar Competência']

    Wait Until Element Is Visible    //input[@id='formBasicEmail']
    Gerar nome do teste
    Sleep    1s
    Input Text    //input[@id='formBasicEmail']    ${NOMETESTE}
    Input Text    //textarea[@id='formBasicEmail']    ${NOMEDESCRICAO}
    Click Element    //button[@class='botao-default btn btn-var(--verde-primario)']

    Wait Until Element Is Visible    //button[.='Confirmar']
    Click Element    //button[.='Confirmar']

*** Test Cases ***

TC 04 Cadastrar competencia
    [Tags]    FLUXO-POSITIVO04
    Realizar Login
    
    Click Element    //button[.='Competência']
    
    Wait Until Element Is Visible    //button[.='Cadastrar Competência']
    Click Element    //button[.='Cadastrar Competência']

    Wait Until Element Is Visible    //input[@id='formBasicEmail']
    Gerar nome do teste
    Sleep    1s
    Input Text    //input[@id='formBasicEmail']    ${NOMETESTE}
    Input Text    //textarea[@id='formBasicEmail']    ${NOMEDESCRICAO}
    Click Element    //button[@class='botao-default btn btn-var(--verde-primario)']

    Wait Until Element Is Visible    //button[.='Confirmar']
    Click Element    //button[.='Confirmar']

    Wait Until Element Is Visible    //div[@class='Toastify__toast Toastify__toast-theme--colored Toastify__toast--success Toastify__toast--close-on-click']

TC 05 Cadastrar competencia vazia
    [Tags]    FLUXO-NEGATIVO05
    Realizar Login
    
    Click Element    //button[.='Competência']
    
    Wait Until Element Is Visible    //button[.='Cadastrar Competência']
    Click Element    //button[.='Cadastrar Competência']

    Wait Until Element Is Visible    //input[@id='formBasicEmail']
    Click Element    //button[@class='botao-default btn btn-var(--verde-primario)']


    Wait Until Element Is Visible    //div[@class='container']/div[1]//div[@class='invalid-feedback']
    
TC 06 Cadastrar competencia repetida
    [Tags]    FLUXO-NEGATIVO06
    Realizar Login
    
    Click Element    //button[.='Competência']
    
    Wait Until Element Is Visible    //button[.='Cadastrar Competência']
    Click Element    //button[.='Cadastrar Competência']

    Wait Until Element Is Visible    //input[@id='formBasicEmail']
    Input Text    //input[@id='formBasicEmail']    ${NOMETESTEREP}
    Input Text    //textarea[@id='formBasicEmail']    ${NOMEDESCRICAOREP}
    Click Element    //button[@class='botao-default btn btn-var(--verde-primario)']

    Wait Until Element Is Visible    //button[.='Confirmar']
    Click Element    //button[.='Confirmar']

    Wait Until Element Is Visible    //input[@class='form-control']
    Wait Until Element Is Visible    //div[@class='Toastify__toast Toastify__toast-theme--colored Toastify__toast--error Toastify__toast--close-on-click']

TC 07 Visualizar competencia
    [Tags]    FLUXO-POSITIVO07
    Realizar Login

    Click Element    //button[.='Competência']
    
    Wait Until Element Is Visible    //button[.='Cadastrar Competência']
    Click Element    //button[.='Buscar Competência']

    Wait Until Element Is Visible    //input[@class='form-control']
    
    Click Element    css:tbody > tr:nth-of-type(1) [color='var(--preto-primario)']

TC 08 Editar competencia
    [Tags]    FLUXO-POSITIVO08
    Realizar Login

    Click Element    //button[.='Competência']
    
    Wait Until Element Is Visible    //button[.='Cadastrar Competência']
    Click Element    //button[.='Buscar Competência']

    Wait Until Element Is Visible    //input[@class='form-control']
    Sleep    1s
    Click Element    css:tbody > tr:nth-of-type(1) [color='var(--preto-primario)']

    Wait Until Element Is Visible    css:.container > div:nth-of-type(4) [stroke='currentColor']
    Click Element    css:.container > div:nth-of-type(4) [stroke='currentColor']
    Gerar nome do teste
    Sleep    1s
    Input Text    css:[maxlength='200']    ${NOMEDESCRICAO}
    Click Element    css:.container > div:nth-of-type(2) [stroke='currentColor']
    Sleep    1s
    Input Text     css:[maxlength='30']    ${NOMETESTE}
    Click Element    //button[@class='botao-default btn btn-var(--verde-primario)']
    Wait Until Element Is Visible    //button[.='Confirmar']
    Click Element    //button[.='Confirmar']

    Sleep    1s
    ${url}=    Get Location
    Should Contain    ${url}    /buscarComp

TC 09 Inativar competencia
    [Tags]    FLUXO-POSITIVO09
    Cadastrar competencia

    Wait Until Element Is Visible    //input[@class='form-control']
    Click Element    //button[@class='botao-default btn btn-var(--cinza-primario)']

    Wait Until Element Is Visible    //button[.='Cadastrar Competência']
    Click Element    //button[.='Buscar Competência']

    Wait Until Element Is Visible    //input[@class='form-control']
    Click Element    //select[@class='select-per-page form-select']
    Wait Until Element Is Visible    //option[.='100']
    Click Element    //option[.='100']
    Input Text    //input[@class='form-control']    ${NOMETESTE}
    
    Wait Until Element Is Visible    css:[color='var(--vermelho-constraste)']
    Click Element    css:[color='var(--vermelho-constraste)']
    Wait Until Element Is Visible    //button[.='Confirmar']
    Click Element    //button[.='Confirmar']

    Wait Until Element Is Visible    //div[@class='Toastify__toast-body']/div[.='Competência excluida com sucesso!']

TC 10 Inativar competencia com colaborador
    [Tags]    FLUXO-NEGATIVO10
    Realizar Login

    Click Element    //button[.='Competência']

    Wait Until Element Is Visible    //button[.='Cadastrar Competência']
    Click Element    //button[.='Buscar Competência']

    Wait Until Element Is Visible    //input[@class='form-control']
    Click Element    //select[@class='select-per-page form-select']
    Wait Until Element Is Visible    //option[.='100']
    Click Element    //option[.='100']
    Input Text    //input[@class='form-control']    ${NOMETESTEREP}
    
    Wait Until Element Is Visible    css:[color='var(--vermelho-constraste)']
    Click Element    css:[color='var(--vermelho-constraste)']
    Wait Until Element Is Visible    //button[.='Confirmar']
    Click Element    //button[.='Confirmar']

    Wait Until Element Is Visible    //td[.='TesteAuto1234']