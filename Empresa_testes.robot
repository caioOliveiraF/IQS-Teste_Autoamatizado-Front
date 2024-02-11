*** Settings ***

Library    SeleniumLibrary
Library    DateTime
Library    FakerLibrary    locale=pt_BR

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

#### Nome do serviço ###

${NOMESERVICO}
${DESCRICAOSERVICO}
${NOMESERVICOREP}    ServiçoAuto1234
${DESCRICAOSERVICOREP}    DescriçãoServiçoAuto1234

#### Nome da Empresa ###

${NOMEEMPRESA}
${SETOREMPRESA}
${CNPJEMPRESA}
${TELEEMPRESA}    99999999999
${ENDERECOEMPRESA}
${NOMEEMPRESAREP}    EmpresaAuto1234
${SETOREMPRESAREP}    SetorAuto1234
${CNPJEMPRESAREP}    33333333333333

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

Gerar nome do serviço
    ${data}    Get Current Date    result_format=%d/%m/%Y %H:%M:%S
    ${NOMESERVICO}    Set Variable    Serviço ${data}
    ${DESCRICAOSERVICO}    Set Variable    Descrição Serviço ${data}
    Set Test Variable    ${NOMESERVICO}
    Set Test Variable    ${DESCRICAOSERVICO}

Gerar nome da empresa
    ${data}    Get Current Date    result_format=%d/%m/%Y %H:%M:%S
    ${NOMEEMPRESA}    Set Variable    Empresa ${data}
    ${SETOREMPRESA}    Set Variable    Setor ${data}
    ${CNPJEMPRESA}    FakerLibrary.cnpj
    ${Estado}    FakerLibrary.state
    ${Cidade}    FakerLibrary.city
    ${CEP}    FakerLibrary.postcode
    ${ENDERECOEMPRESA}    Set Variable    ${Estado}, ${Cidade} - ${CEP}
    Set Test Variable    ${NOMEEMPRESA}
    Set Test Variable    ${SETOREMPRESA}
    Set Test Variable    ${CNPJEMPRESA}
    Set Test Variable    ${ENDERECOEMPRESA}

Cadastrar empresa
    Realizar Login

    Click Element    //button[.='Empresa']

    Wait Until Element Is Visible    //button[.='Cadastrar Empresa']
    Click Element    //button[.='Cadastrar Empresa']

    Wait Until Element Is Visible    //span[.='Selecione o nome da empresa e suas informações']
    Gerar nome da empresa
    Sleep    1s
    Input Text    //div[@class='container']/div[1]/div[1]//input[@id='formBasicEmail']    ${NOMEEMPRESA}
    Input Text    //div[@class='container']/div[@class='row']/div[2]//input[@id='formBasicEmail']    ${CNPJEMPRESA}
    Input Text    //div[@class='container']//div[3]//input[@id='formBasicEmail']    ${TELEEMPRESA}
    Input Text    //div[@class='container']/div[2]//input[@id='formBasicEmail']    ${SETOREMPRESA}
    Input Text    //textarea[@id='formBasicEmail']    ${ENDERECOEMPRESA}
    Click Element    //button[@class='botao-default btn btn-var(--verde-primario)']
    Wait Until Element Is Visible    //div[@class='sc-aXZVg hDPZGJ']/button[@class='botao-default btn btn-var(--verde-primario)']
    Click Element    //div[@class='sc-aXZVg hDPZGJ']/button[@class='botao-default btn btn-var(--verde-primario)']
    
    Wait Until Element Is Visible    //div[@class='Toastify__toast-body']/div[.='Empresa cadastrada com sucesso!']
    Click Element    //select[@class='select-per-page form-select']
    Wait Until Element Is Visible    //option[.='100']
    Click Element    //option[.='100']
    Input Text    //input[@class='form-control']    ${NOMESERVICOREP}
    Wait Until Element Is Visible    css:[color='var(--preto-primario)']
    Click Element    css:[color='var(--preto-primario)']
    Click Element    //button[@class='botao-default btn btn-var(--verde-primario)']
    Wait Until Element Is Visible    //button[.='Confirmar']
    Click Element    //button[.='Confirmar']

    Wait Until Element Is Visible    //div[@class='Toastify__toast-body']/div[.='Serviço vinculado com sucesso!']


*** Test Cases ***
TC 24 Cadastrar empresa
    [Tags]    FLUXO-POSITIVO24
    Realizar Login

    Click Element    //button[.='Empresa']

    Wait Until Element Is Visible    //button[.='Cadastrar Empresa']
    Click Element    //button[.='Cadastrar Empresa']

    Wait Until Element Is Visible    //span[.='Selecione o nome da empresa e suas informações']
    Gerar nome da empresa
    Sleep    1s
    Input Text    //div[@class='container']/div[1]/div[1]//input[@id='formBasicEmail']    ${NOMEEMPRESA}
    Input Text    //div[@class='container']/div[@class='row']/div[2]//input[@id='formBasicEmail']    ${CNPJEMPRESA}
    Input Text    //div[@class='container']//div[3]//input[@id='formBasicEmail']    ${TELEEMPRESA}
    Input Text    //div[@class='container']/div[2]//input[@id='formBasicEmail']    ${SETOREMPRESA}
    Input Text    //textarea[@id='formBasicEmail']    ${ENDERECOEMPRESA}
    Click Element    //button[@class='botao-default btn btn-var(--verde-primario)']
    Wait Until Element Is Visible    //div[@class='sc-aXZVg hDPZGJ']/button[@class='botao-default btn btn-var(--verde-primario)']
    Click Element    //div[@class='sc-aXZVg hDPZGJ']/button[@class='botao-default btn btn-var(--verde-primario)']
    
    Wait Until Element Is Visible    //div[@class='Toastify__toast-body']/div[.='Empresa cadastrada com sucesso!']
    Click Element    //select[@class='select-per-page form-select']
    Wait Until Element Is Visible    //option[.='100']
    Click Element    //option[.='100']
    Input Text    //input[@class='form-control']    ${NOMESERVICOREP}
    Wait Until Element Is Visible    css:[color='var(--preto-primario)']
    Click Element    css:[color='var(--preto-primario)']
    Click Element    //button[@class='botao-default btn btn-var(--verde-primario)']
    Wait Until Element Is Visible    //button[.='Confirmar']
    Click Element    //button[.='Confirmar']

    Wait Until Element Is Visible    //div[@class='Toastify__toast-body']/div[.='Serviço vinculado com sucesso!']

TC 25 Cadastrar empresa vazia
    [Tags]    FLUXO-NEGATIVO25
    Realizar Login

    Click Element    //button[.='Empresa']

    Wait Until Element Is Visible    //button[.='Cadastrar Empresa']
    Click Element    //button[.='Cadastrar Empresa']

    Wait Until Element Is Visible    //span[.='Selecione o nome da empresa e suas informações']
    Click Element    css:.sc-aXZVg > .botao-default

    Wait Until Element Is Visible    //div[@class='container']/div[1]/div[1]//div[@class='invalid-feedback']

TC 26 Cadastrar empresa com cnpj repetido
    [Tags]    FLUXO-NEGATIVO26
    Realizar Login

    Click Element    //button[.='Empresa']

    Wait Until Element Is Visible    //button[.='Cadastrar Empresa']
    Click Element    //button[.='Cadastrar Empresa']

    Wait Until Element Is Visible    //span[.='Selecione o nome da empresa e suas informações']
    Gerar nome da empresa
    Sleep    1s
    Input Text    //div[@class='container']/div[1]/div[1]//input[@id='formBasicEmail']    ${NOMEEMPRESAREP}
    Input Text    //div[@class='container']/div[@class='row']/div[2]//input[@id='formBasicEmail']    ${CNPJEMPRESAREP}
    Input Text    //div[@class='container']//div[3]//input[@id='formBasicEmail']    ${TELEEMPRESA}
    Input Text    //div[@class='container']/div[2]//input[@id='formBasicEmail']    ${SETOREMPRESAREP}
    Input Text    //textarea[@id='formBasicEmail']    ${ENDERECOEMPRESA}
    Click Element    //button[@class='botao-default btn btn-var(--verde-primario)']
    Wait Until Element Is Visible    //div[@class='sc-aXZVg hDPZGJ']/button[@class='botao-default btn btn-var(--verde-primario)']
    Click Element    //div[@class='sc-aXZVg hDPZGJ']/button[@class='botao-default btn btn-var(--verde-primario)']
    Wait Until Element Is Visible    //div[@class='Toastify__toast-body']/div[contains(.,'Erro ao criar a empresa: 400 BAD_REQUEST "Já existe uma empresa com o CNPJ infor')]

TC 27 Cadastrar empresa
    [Tags]    FLUXO-POSITIVO27
    Realizar Login

    Click Element    //button[.='Empresa']

    Wait Until Element Is Visible    //button[.='Cadastrar Empresa']
    Click Element    //button[.='Buscar Empresa']

    Wait Until Element Is Visible    //span[.='Buscar Empresa']
    Click Element    //select[@class='select-per-page form-select']
    Wait Until Element Is Visible    //option[.='100']
    Click Element    //option[.='100']
    Input Text    //input[@class='form-control']    ${NOMEEMPRESAREP}
    Wait Until Element Is Visible    css:[color='var(--preto-primario)'][viewBox='0 0 16 16']
    Click Element    css:[color='var(--preto-primario)'][viewBox='0 0 16 16']

    Wait Until Element Is Visible    //span[.='Detalhar Empresa']

TC 28 Cadastrar empresa
    [Tags]    FLUXO-POSITIVO28
    Realizar Login

    Click Element    //button[.='Empresa']

    Wait Until Element Is Visible    //button[.='Cadastrar Empresa']
    Click Element    //button[.='Buscar Empresa']

    Wait Until Element Is Visible    //span[.='Buscar Empresa']
    Wait Until Element Is Visible    css:tbody > tr:nth-of-type(1) svg:nth-of-type(1)
    Click Element    css:tbody > tr:nth-of-type(1) svg:nth-of-type(1)

    Wait Until Element Is Visible    //span[.='Detalhar Empresa']
    Gerar nome da empresa
    Sleep    1s
    Click Element    css:.mb-3 > div:nth-of-type(1) [stroke='currentColor']
    Click Element    css:.mb-3 > div:nth-of-type(2) [stroke='currentColor']
    Click Element    css:.mb-3 > div:nth-of-type(3) [stroke='currentColor']    
    Click Element    css:.mb-3 > div:nth-of-type(4) [stroke='currentColor']
    Input Text    //div[@class='mb-3 row']/div[contains(.,'Nome')]/input    ${NOMEEMPRESA}
    Input Text    //div[@class='mb-3 row']/div[contains(.,'CNPJ')]/input    ${CNPJEMPRESA}
    Input Text    //div[@class='mb-3 row']/div[contains(.,'Telefone')]/input    ${TELEEMPRESA}
    Input Text    //div[@class='mb-3 row']/div[contains(.,'Setor')]/input    ${SETOREMPRESA}

    Click Element    //button[@class='botao-default btn btn-var(--verde-primario)']
    Wait Until Element Is Visible    //button[.='Confirmar']
    Click Element    //button[.='Confirmar']

    Wait Until Element Is Visible    //div[@class='Toastify__toast-body']/div[.='Alterações salvas com Sucesso!']

TC 29 Inativar empresa
    [Tags]    FLUXO-POSITIVO29
    Cadastrar empresa

    Wait Until Element Is Visible    //input[@class='form-control']
    Click Element    //img[@alt='T2M']
    Wait Until Element Is Visible    //img[@alt='SC']
    Click Element    //img[@alt='SC']

    Wait Until Element Is Visible    //button[.='Empresa']
    Click Element    //button[.='Empresa']

    Wait Until Element Is Visible    //button[.='Cadastrar Empresa']
    Click Element    //button[.='Buscar Empresa']

    Wait Until Element Is Visible    //input[@class='form-control']
    Click Element    //select[@class='select-per-page form-select']
    Wait Until Element Is Visible    //option[.='100']
    Click Element    //option[.='100']
    Input Text    //input[@class='form-control']    ${NOMEEMPRESA}
    
    Wait Until Element Is Visible    css:[color='var(--vermelho-constraste)']
    Click Element    css:[color='var(--vermelho-constraste)']
    Wait Until Element Is Visible    //button[@class='botao-default btn btn-var(--verde-primario)']
    Click Element    //button[@class='botao-default btn btn-var(--verde-primario)']

    Wait Until Element Is Visible    //div[@class='Toastify__toast-body']/div[.='Empresa excluída com sucesso!']