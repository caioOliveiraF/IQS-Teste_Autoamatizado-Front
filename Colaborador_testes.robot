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

${NOMETESTEREP}    TesteAuto1234

### Colaboradores ###

${COLABORADOR}    gestor

### Nome da empresa ###

${NOMEEMPRESAREP}    EmpresaAuto1234

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
TC 11 Visualizar colaborador
    [Tags]    FLUXO-POSITIVO11
    Realizar Login

    Click Element    //button[.='Colaborador']

    Wait Until Element Is Visible    //input[@class='form-control']
    Input Text    //input[@class='form-control']    ${COLABORADOR}

    Wait Until Element Is Visible    css:[height='1em'][viewBox='0 0 16 16']
    Click Element    css:[height='1em'][viewBox='0 0 16 16']

    Wait Until Element Is Visible    //span[.='Detalhar Colaborador']

TC 12 Vincular competencia ao colaborador
    [Tags]    FLUXO-POSITIVO12
    Realizar Login

    Click Element    //button[.='Colaborador']

    Wait Until Element Is Visible    //input[@class='form-control']
    Input Text    //input[@class='form-control']    ${COLABORADOR}

    Wait Until Element Is Visible    css:svg:nth-of-type(2)
    Click Element    css:svg:nth-of-type(2)

    Wait Until Element Is Visible    //input[@class='form-control']
    Click Element    //button[@class='botao-default btn btn-var(--verde-primario)']

    Wait Until Element Is Visible    //input[@class='form-control']
    Click Element    //select[@class='select-per-page form-select']
    Wait Until Element Is Visible    //option[.='100']
    Click Element    //option[.='100']
    Input Text    //input[@class='form-control']    ${NOMETESTEREP}

    Wait Until Element Is Visible    css:svg:nth-of-type(2)
    Click Element    css:svg:nth-of-type(2)
    Click Element    //button[@class='botao-default btn btn-var(--verde-primario)']

    Wait Until Element Is Visible    //body[@class='modal-open']/div[6]//button[@class='botao-default btn btn-var(--verde-primario)']
    Click Element    //body[@class='modal-open']/div[6]//button[@class='botao-default btn btn-var(--verde-primario)']

    Wait Until Element Is Visible    //div[@class='Toastify__toast-body']/div[.='Competência vinculada com sucesso!']

TC 13 Desvincular competencia do colaborador
    [Tags]    FLUXO-POSITIVO13
    Realizar Login

    Click Element    //button[.='Colaborador']

    Wait Until Element Is Visible    //input[@class='form-control']
    Input Text    //input[@class='form-control']    ${COLABORADOR}

    Wait Until Element Is Visible    css:svg:nth-of-type(2)
    Click Element    css:svg:nth-of-type(2)

    Wait Until Element Is Visible    //input[@class='form-control']
    Input Text    //input[@class='form-control']    ${NOMETESTEREP}
    Click Element    //*[local-name()='svg'][2]

    Wait Until Element Is Visible    //button[.='Confirmar']
    Click Element    //button[.='Confirmar']

    Wait Until Element Is Visible    //div[@class='Toastify__toast-body']/div[.='Competência desvinculada com sucesso!']

TC 14 Vincular empresa ao colaborador
    [Tags]    FLUXO-POSITIVO14
    Realizar Login

    Click Element    //button[.='Colaborador']

    Wait Until Element Is Visible    //input[@class='form-control']
    Input Text    //input[@class='form-control']    ${COLABORADOR}

    Wait Until Element Is Visible    css:[height='1em'][viewBox='0 0 16 16']
    Click Element    css:[height='1em'][viewBox='0 0 16 16']

    Wait Until Element Is Visible    //span[.='Detalhar Colaborador']
    Click Element    css:[color='var(--verde-primario)']

    Wait Until Element Is Visible    //span[.='Adicionar Empresa ao Colaborador']
    Click Element    //select[@class='select-per-page form-select']
    Wait Until Element Is Visible    //option[.='100']
    Click Element    //option[.='100']
    Input Text    //input[@class='form-control']    ${NOMEEMPRESAREP}
    Click Element    //input[@name='companySelection']
    Click Element    //button[@class='botao-default btn btn-var(--verde-primario)']
    Wait Until Element Is Visible    //div[@class='sc-aXZVg hDPZGJ']/button[@class='botao-default btn btn-var(--verde-primario)']
    Click Element    //div[@class='sc-aXZVg hDPZGJ']/button[@class='botao-default btn btn-var(--verde-primario)']

    Wait Until Element Is Visible    //div[@class='Toastify__toast-body']/div[.='Empresa vinculada com sucesso!']