#Airton Negromonte
#Bruno Souza
#Ronaldo Silva

*** Settings ***
Library    SeleniumLibrary

*** Variables ***
#Acessar a loja
${SITE}                         https://demo.spreecommerce.org
${NAVEGADOR}                    Chrome

#Selecionar categoria
${CATEGORIA}                    xpath=//a[contains(text(),'Women')]

#Selecionar produto
${PRODUTO}                       css=#product_70 .product-component-image

#Selecionar um tamanho e cor
${COR}                          css=.m-1 > span
${TAMANHO}                      css=g:nth-child(2) > circle:nth-child(1)

#Adicionar ao carrinho de compras
${CARRINHO}                     id=add-to-cart-button
${CHECKOUT}                     css=.btn-primary:nth-child(1)

#Login
${USERNAME_CAMPO}               id=spree_user_email
${VALOR_USERNAME}               teste123456@mail.com
${PASSWORD_CAMPO}               id=spree_user_password
${VALOR_PASSWORD}               123456789
${LOGIN}                        name=commit

#Preencher dados de billing address e clicar em Save and Continue
${PRIMEIRO_NOME_CAMPO}          id=order_bill_address_attributes_firstname
${PRIMEIRO_NOME_VALOR}          Barbara
${SEGUNDO_NOME_CAMPO}           id=order_bill_address_attributes_lastname
${SEGUNDO_NOME_VALOR}           G. Cross
${ENDERECO_CAMPO}               id=order_bill_address_attributes_address1
${ENDERECO_VALOR}               Rua Noventa e Oito
${CIDADE_CAMPO}                 id=order_bill_address_attributes_city
${CIDADE_VALOR}                 São Luís
${CEP_CAMPO}                    id=order_bill_address_attributes_zipcode
${CEP_VALOR}                    74931
${TELEFONE_CAMPO}               id=order_bill_address_attributes_phone
${TELEFONE_VALOR}               (91) 2223-4469
${ADDRESS_CONTINUAR}            name=commit

#Selecionar frete e clicar em Save and Continue
${FRETE}                        css=.shipping-method:nth-child(2) .spree-radio-label-custom-input
${DELIVERY_CONTINUAR}           name=commit

#Preencher dados do cartão de crédito, clicar em “Save and Continue”
${CARTAO_CAMPO}                 css=#card_number
${CARTAO_VALOR}                 5384 8981 4865 9875
${VALIDADE_CAMPO}               id=card_expiry
${VALIDADE_VALOR}               03/2025
${CVV_CAMPO}                    id=card_code
${CVV_VALOR}                    380
${PAYMENT_CONTINUAR}            name=commit

#Checar informações e clicar em “place order”
${PLACE_ORDER}                  name=commit

*** Keywords ***
Acessar a loja
    Open Browser  ${SITE}  ${NAVEGADOR}
    Maximize Browser Window

Selecionar categoria
    Click Element  ${CATEGORIA}
    Sleep    3

Selecionar produto
    Click Element  ${PRODUTO}
    Sleep    3

Selecionar um tamanho e cor
    Click Element  ${TAMANHO}
    Sleep    2
    Click Element  ${COR}
    Sleep    3

Adicionar ao carrinho de compras
    Click Element  ${CARRINHO}
    Sleep    3
    Click Element  ${CHECKOUT}
    Sleep    3

Login
    Input Text  ${USERNAME_CAMPO}  ${VALOR_USERNAME}
    Input Text  ${PASSWORD_CAMPO}  ${VALOR_PASSWORD}
    Sleep    2
    Click Element  ${LOGIN}
    Sleep    3

Preencher dados de billing address e clicar em Save and Continue
    Input Text  ${PRIMEIRO_NOME_CAMPO}  ${PRIMEIRO_NOME_VALOR}
    Sleep    2
    Input Text  ${SEGUNDO_NOME_CAMPO}  ${SEGUNDO_NOME_VALOR}
    Sleep    2
    Input Text  ${ENDERECO_CAMPO}  ${ENDERECO_VALOR}
    Sleep    2
    Input Text  ${CIDADE_CAMPO}  ${CIDADE_VALOR}
    Sleep    2
    Input Text  ${CEP_CAMPO}  ${CEP_VALOR}
    Sleep    2
    Input Text  ${TELEFONE_CAMPO}  ${TELEFONE_VALOR}
    Sleep    2
    Click Element  ${ADDRESS_CONTINUAR}
    Sleep    2

Selecionar frete e clicar em Save and Continue
    Click Element  ${FRETE}
    Sleep    2
    Click Element  ${DELIVERY_CONTINUAR}
    Sleep    2

Preencher dados do cartão de crédito, clicar em “Save and Continue”
    Input Text  ${CARTAO_CAMPO}  ${CARTAO_VALOR}
    Sleep    2
    Input Text  ${VALIDADE_CAMPO}  ${VALIDADE_VALOR}
    Sleep    2
    Input Text  ${CVV_CAMPO}  ${CVV_VALOR}
    Sleep    2
    Click Element  ${PAYMENT_CONTINUAR}
    Sleep    2

Checar informações e clicar em “place order”
    Run Keyword And Continue On Failure    Click Element    ${PLACE_ORDER}
    Run Keyword If    '${PREV_TEST_STATUS}' == 'FAIL'    Fatal Error    Bogus Gateway: Forced failure
    BuiltIn.Log To Console    Bogus Gateway: Forced failure
    Sleep    5s
    Close Browser