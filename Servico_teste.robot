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

#### Nome do serviço ###

${NOMESERVICO}
${DESCRICAOSERVICO}
${NOMESERVICOREP}    ServiçoAuto1234
${DESCRICAOSERVICOREP}    DescriçãoServiçoAuto1234

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

Gerar nome do serviço
    ${data}    Get Current Date    result_format=%d/%m/%Y %H:%M:%S
    ${NOMESERVICO}    Set Variable    Serviço ${data}
    ${DESCRICAOSERVICO}    Set Variable    Descrição Serviço ${data}
    Set Test Variable    ${NOMESERVICO}
    Set Test Variable    ${DESCRICAOSERVICO}

Cadastrar serviço
    Realizar Login
    
    Click Element    //button[.='Serviço']
    
    Wait Until Element Is Visible    //button[.='Cadastrar Serviço']
    Click Element    //button[.='Cadastrar Serviço']

    Wait Until Element Is Visible    //span[.='Cadastrar Serviço']
    Gerar nome do serviço
    Sleep    1s
    Input Text    //input[@id='formBasicEmail']    ${NOMESERVICO}
    Input Text    //textarea[@id='formBasicEmail']    ${DESCRICAOSERVICO}
    Click Element    //button[@class='botao-default btn btn-var(--verde-primario)']

    Wait Until Element Is Visible    //button[.='Confirmar']
    Click Element    //button[.='Confirmar']

    Wait Until Element Is Visible    css:tbody > tr:nth-of-type(1) [viewBox='0 0 512 512']
    Click Element    css:tbody > tr:nth-of-type(1) [viewBox='0 0 512 512']
    Click Element    //button[@class='botao-default btn btn-var(--verde-primario)']

    Wait Until Element Is Visible    //div[@class='modal-body']
    Click Element    //button[.='Confirmar']

    Wait Until Element Is Visible    //div[@class='Toastify__toast-body']/div[.='Competência vinculada com sucesso!']


*** Test Cases ***
TC 17 Cadastrar serviço
    [Tags]    FLUXO-POSITIVO17
    Realizar Login
    
    Click Element    //button[.='Serviço']
    
    Wait Until Element Is Visible    //button[.='Cadastrar Serviço']
    Click Element    //button[.='Cadastrar Serviço']

    Wait Until Element Is Visible    //span[.='Cadastrar Serviço']
    Gerar nome do serviço
    Sleep    1s
    Input Text    //input[@id='formBasicEmail']    ${NOMESERVICO}
    Input Text    //textarea[@id='formBasicEmail']    ${DESCRICAOSERVICO}
    Click Element    //button[@class='botao-default btn btn-var(--verde-primario)']

    Wait Until Element Is Visible    //button[.='Confirmar']
    Click Element    //button[.='Confirmar']

    Wait Until Element Is Visible    //div[@class='Toastify__toast-body']/div[.='Serviço cadastrado com sucesso!']
    
    Wait Until Element Is Visible    css:tbody > tr:nth-of-type(1) [viewBox='0 0 512 512']
    Click Element    css:tbody > tr:nth-of-type(1) [viewBox='0 0 512 512']
    Click Element    //button[@class='botao-default btn btn-var(--verde-primario)']

    Wait Until Element Is Visible    //div[@class='modal-body']
    Click Element    //button[.='Confirmar']

    Wait Until Element Is Visible    //div[@class='Toastify__toast-body']/div[.='Competência vinculada com sucesso!']

TC 18 Cadastrar serviço vazia
    [Tags]    FLUXO-NEGATIVO18
    Realizar Login
    
    Click Element    //button[.='Serviço']
    
    Wait Until Element Is Visible    //button[.='Cadastrar Serviço']
    Click Element    //button[.='Cadastrar Serviço']

    Wait Until Element Is Visible    //span[.='Cadastrar Serviço']
    Click Element    //button[@class='botao-default btn btn-var(--verde-primario)']


    Wait Until Element Is Visible    //form[1]//div[@class='invalid-feedback']

TC 19 Cadastrar serviço repetido
    [Tags]    FLUXO-NEGATIVO19
    Realizar Login
    
    Click Element    //button[.='Serviço']
    
    Wait Until Element Is Visible    //button[.='Cadastrar Serviço']
    Click Element    //button[.='Cadastrar Serviço']

    Wait Until Element Is Visible    //span[.='Cadastrar Serviço']
    Input Text    //input[@id='formBasicEmail']    ${NOMESERVICOREP} 
    Input Text    //textarea[@id='formBasicEmail']    ${DESCRICAOSERVICOREP}
    Click Element    //button[@class='botao-default btn btn-var(--verde-primario)']

    Wait Until Element Is Visible    //button[.='Confirmar']
    Click Element    //button[.='Confirmar']

    Wait Until Element Is Visible    //div[@class='Toastify__toast Toastify__toast-theme--colored Toastify__toast--error Toastify__toast--close-on-click']

TC 20 Visualizar serviço
    [Tags]    FLUXO-POSITIVO20
    Realizar Login

    Click Element    //button[.='Serviço']
    
    Wait Until Element Is Visible    //button[.='Cadastrar Serviço']
    Click Element    //button[.='Buscar Serviço']

    Wait Until Element Is Visible    css:tbody > tr:nth-of-type(1) svg:nth-of-type(1)
    Click Element    css:tbody > tr:nth-of-type(1) svg:nth-of-type(1)

    Wait Until Element Is Visible    //span[.='Detalhar Serviço']

TC 21 Editar serviço
    [Tags]    FLUXO-POSITIVO21
    Realizar Login

    Click Element    //button[.='Serviço']
    
    Wait Until Element Is Visible    //button[.='Cadastrar Serviço']
    Click Element    //button[.='Buscar Serviço']

    Wait Until Element Is Visible    css:tbody > tr:nth-of-type(1) svg:nth-of-type(1)
    Click Element    css:tbody > tr:nth-of-type(1) svg:nth-of-type(1)

    Wait Until Element Is Visible    //span[.='Detalhar Serviço']
    Click Element    css:.container > div:nth-of-type(2) [stroke='currentColor']
    Gerar nome do serviço
    Sleep    1s
    Input Text    css:[maxlength='30']    ${NOMESERVICO}
    Click Element    css:.container > div:nth-of-type(4) [stroke='currentColor']
    Sleep    1s
    Input Text     css:[maxlength='60']    ${DESCRICAOSERVICO}
    Click Element    //button[@class='botao-default btn btn-var(--verde-primario)']
    Wait Until Element Is Visible    //button[.='Confirmar']
    Click Element    //button[.='Confirmar']

    Wait Until Element Is Visible    //div[@class='Toastify__toast-body']/div[.='Alterações salvas!']

TC 22 Inativar serviço
    [Tags]    FLUXO-POSITIVO22
    Cadastrar serviço

    Wait Until Element Is Visible    //input[@class='form-control']
    Click Element    //img[@alt='T2M']
    Wait Until Element Is Visible    //img[@alt='SC']
    Click Element    //img[@alt='SC']

    Wait Until Element Is Visible    //button[.='Serviço']
    Click Element    //button[.='Serviço']

    Wait Until Element Is Visible    //button[.='Cadastrar Serviço']
    Click Element    //button[.='Buscar Serviço']

    Wait Until Element Is Visible    //input[@class='form-control']
    Click Element    //select[@class='select-per-page form-select']
    Wait Until Element Is Visible    //option[.='100']
    Click Element    //option[.='100']
    Input Text    //input[@class='form-control']    ${NOMESERVICO}
    
    Wait Until Element Is Visible    css:[color='var(--vermelho-constraste)']
    Click Element    css:[color='var(--vermelho-constraste)']
    Wait Until Element Is Visible    //button[@class='botao-default btn btn-var(--verde-primario)']
    Click Element    //button[@class='botao-default btn btn-var(--verde-primario)']

    Wait Until Element Is Visible    //div[@class='Toastify__toast-body']/div[.='Serviço excluído com sucesso!']

TC 23 Inativar serviço com empresa
    [Tags]    FLUXO-NEGATIVO23
    Realizar Login

    Click Element    //button[.='Serviço']
    
    Wait Until Element Is Visible    //button[.='Cadastrar Serviço']
    Click Element    //button[.='Buscar Serviço']

    Wait Until Element Is Visible    //input[@class='form-control']
    Click Element    //select[@class='select-per-page form-select']
    Wait Until Element Is Visible    //option[.='100']
    Click Element    //option[.='100']
    Input Text    //input[@class='form-control']    ${NOMESERVICOREP}
    
    Wait Until Element Is Visible    css:[color='var(--vermelho-constraste)']
    Click Element    css:[color='var(--vermelho-constraste)']
    Wait Until Element Is Visible    //button[@class='botao-default btn btn-var(--verde-primario)']
    Click Element    //button[@class='botao-default btn btn-var(--verde-primario)']

    Wait Until Element Is Visible    //div[@class='Toastify__toast-body']/div[.='Não é possível excluir o serviço porque está vinculado a empresas.']