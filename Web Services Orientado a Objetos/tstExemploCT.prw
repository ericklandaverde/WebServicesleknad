#include "protheus.ch"
#include "apwebsrv.ch"         
 
User Function tstExemploCT
 
Local oWsdl := WSEXEMPLOCT():New()
Local oCadastro
Local oLista
 
WSDLDbgLevel( 3 )
 
// Cria o array de clientes (WSDATA oWSREGISTROS AS EXEMPLOCT_ARRAYOFCLIENTE )
oWsdl:oWS_DADOS:oWSREGISTROS := EXEMPLOCT_ARRAYOFCLIENTE():New()
 
// Cria e alimenta uma nova instancia do cliente
oCadastro := EXEMPLOCT_CLIENTE():New()
oCadastro:cNOME := "AAA"
oCadastro:cTELEFONE := "111"
AAdd( oWsdl:oWS_DADOS:oWSREGISTROS:oWSCLIENTE, oCadastro )
 
// Cria e alimenta uma nova instancia do cliente
oCadastro := EXEMPLOCT_CLIENTE():New()
oCadastro:cNOME := "BBB"
oCadastro:cTELEFONE := "222"
AAdd( oWsdl:oWS_DADOS:oWSREGISTROS:oWSCLIENTE, oCadastro )
 
// Cria e alimenta uma nova instancia do cliente
oCadastro := EXEMPLOCT_CLIENTE():New()
oCadastro:cNOME := "CCC"
AAdd( oWsdl:oWS_DADOS:oWSREGISTROS:oWSCLIENTE, oCadastro )
 
// Exibe os dados inseridos
varinfo( "oWSREGISTROS", oWsdl:oWS_DADOS:oWSREGISTROS )
 
// Executa a operação InsereClientes.
// Ela exibirá os dados recebidos, que devem ser os mesmos que foram criados aqui.
xRet := oWsdl:INSERECLIENTES()
 
// Exibe o valor do status recebido na mensagem SOAP de resposta da operação.
varinfo( "Status", oWsdl:lINSERECLIENTESRESULT )
 
// Exbie o retorno do método, informando se a operação foi executada com sucesso.
varinfo( "xRet", xRet )
 
conout( "" )
 
IF !xRet
   conout( "Erro no processamento: " + GetWSCError() )
   return
Endif
 
conout( "Tudo certo" )
 
// Agora iremos executar a operação ListaClientes, que irá devolver os dados aramazenados.
// No nosso exemplo irá devolver sempre os mesmos valores.
 
// Aqui mostra que a variável está Nil.
varinfo("Lista", oLista )
 
// Executa a operação ListaClientes.
xRet := oWsdl:LISTACLIENTES()
 
// Exbie o retorno do método, informando se a operação foi executada com sucesso.
varinfo("xRet", xRet )
 
conout( "" )
 
IF !xRet
   conout( "Erro no processamento: " + GetWSCError( 3 ) )
   return
Endif
 
conout("Tudo certo")
 
// Seta o valor da variável com o valor recebido na mensagem SOAP de resposta da operação.
oLista := oWsdl:oWSLISTACLIENTESRESULT
 
// Exibe o conteúdo recebido
varinfo("Lista", oLista )
 
Return