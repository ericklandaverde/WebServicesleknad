#include "protheus.ch"
#include "apwebsrv.ch"
 

 //Se crea la  clase "Cliente". //Con los atributos nombre, telefono. //Se usa el Keyword WSSTRUCT/ENDWSSTRUCT
WSSTRUCT Cliente
  WSDATA Nome AS String
  WSDATA Telefone AS String OPTIONAL
ENDWSSTRUCT

//Se crea la  clase "Clientes". //Con los atributos Registros. //Se usa el Keyword WSSTRUCT/ENDWSSTRUCT

WSSTRUCT Clientes
  WSDATA Registros AS ARRAY OF Cliente
ENDWSSTRUCT
 
WSSERVICE ExemploCT
  WSDATA _status AS Boolean
  WSDATA _dados AS Clientes
  WSMETHOD InsereClientes //Se usara el Metodo Insertar Clientes
  WSMETHOD ListaClientes ////Se usara el Metodo Listar Clientes
ENDWSSERVICE
 
 //Metodo Insertar clientes recibe "dados" 
WSMETHOD InsereClientes WSRECEIVE _dados WSSEND _status WSSERVICE ExemploCT
  
  Local nI   
  // Exibe os dados recebidos. Eles seriam inseridos em um tabela num banco de dados.
  for nI := 1 to Len( ::_dados:Registros )
    conout( "Registro " + cValToChar(nI) )
    conout( "Nombre: " + ::_dados:Registros[nI]:Nome )
    conout( "Telefono: " + IIf( Empty( ::_dados:Registros[nI]:Telefone ), "Nao tem", ::_dados:Registros[nI]:Telefone ) + CRLF )
  next nI
   
  // Devove um status informando que a operação foi feita com sucesso. Esse status será devolvido na mensagem SOAP de resposta a esse método.
  ::_status := .T.
   
// Retorna que a operação foi feita com sucesso para a camada do Protheus. 
Return .T.
 
WSMETHOD ListaClientes WSRECEIVE NULLPARAM WSSEND _dados WSSERVICE ExemploCT
  Local nDay:= dow(date())
  Local oNewCliente
   
  if nDay == 1 .Or. nDay == 7
    SetSoapFault( "Metodo não disponível", "Este serviço não funciona no fim de semana." )
     
    return .F.
  endif
   
  // Os dados de retorno seriam pegos do banco de dados.
  // Para esse exemplo iremos popular o retorno com dados fixos.
   
  // Cria a instância de retorno ( WSDATA _dados AS Clientes )
  ::_dados:= WSClassNew("Clientes")
   
  // inicializa a propriedade da estrutura de retorno
  // WSDATA Registros AS ARRAY OF Cliente
   
  ::_dados:Registros := {}
   
  // Cria e alimenta uma nova instancia do cliente
  // Se crea y alimenta una nueva instancia de cliente
  oNewCliente:=WSClassNew("Cliente")
  oNewCliente:Nome:= "ZZZ"
  oNewCliente:Telefone:= "999"
  AAdd(::_dados:Registros, oNewCliente )
   
  // Cria e alimenta uma nova instancia do cliente
  oNewCliente:=WSClassNew("Cliente")
  oNewCliente:Nome:= "EEE"
  oNewCliente:Telefone:= "777"
  AAdd(::_dados:Registros, oNewCliente )
   
// Retorna que a operação foi feita com sucesso para a camada do Protheus. 
Return .T.