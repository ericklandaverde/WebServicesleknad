#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"
 
/* ===============================================================================
WSDL Location    http://localhost/EXEMPLOCT.apw?WSDL
Gerado em        02/07/14 10:55:12
Observações      Código-Fonte gerado por ADVPL WSDL Client 1.120703
                 Alterações neste arquivo podem causar funcionamento incorreto
                 e serão perdidas caso o código-fonte seja gerado novamente.
=============================================================================== */
 
User Function DUMMY ; Return  // "dummy" function - Internal Use
 
/* -------------------------------------------------------------------------------
WSDL Service WSEXEMPLOCT
------------------------------------------------------------------------------- */
 
WSCLIENT WSEXEMPLOCT
 
    WSMETHOD NEW 
    WSMETHOD INIT
    WSMETHOD RESET
    WSMETHOD CLONE
    WSMETHOD INSERECLIENTES
    WSMETHOD LISTACLIENTES
 
    WSDATA   _URL                      AS String
    WSDATA   _HEADOUT                  AS Array of String
    WSDATA   _COOKIES                  AS Array of String
    WSDATA   oWS_DADOS                 AS EXEMPLOCT_CLIENTES
    WSDATA   lINSERECLIENTESRESULT     AS boolean
    WSDATA   oWSLISTACLIENTESRESULT    AS EXEMPLOCT_CLIENTES
 
    // Estruturas mantidas por compatibilidade - NÃO USAR
    WSDATA   oWSCLIENTES               AS EXEMPLOCT_CLIENTES
 
ENDWSCLIENT
 
WSMETHOD NEW WSCLIENT WSEXEMPLOCT
::Init()
If !FindFunction("XMLCHILDEX")
    UserException("O Código-Fonte Client atual requer os executáveis do Protheus Build [7.00.131227A-20140131] ou superior. Atualize o Protheus ou gere o Código-Fonte novamente utilizando o Build atual.")
EndIf
Return Self
 
WSMETHOD INIT WSCLIENT WSEXEMPLOCT
    ::oWS_DADOS          := EXEMPLOCT_CLIENTES():New()
    ::oWSLISTACLIENTESRESULT := EXEMPLOCT_CLIENTES():New()
 
    // Estruturas mantidas por compatibilidade - NÃO USAR
    ::oWSCLIENTES        := ::oWS_DADOS
Return
 
WSMETHOD RESET WSCLIENT WSEXEMPLOCT
    ::oWS_DADOS          := NIL
    ::lINSERECLIENTESRESULT := NIL
    ::oWSLISTACLIENTESRESULT := NIL
 
    // Estruturas mantidas por compatibilidade - NÃO USAR
    ::oWSCLIENTES        := NIL
    ::Init()
Return
 
WSMETHOD CLONE WSCLIENT WSEXEMPLOCT
Local oClone := WSEXEMPLOCT():New()
    oClone:_URL          := ::_URL
    oClone:oWS_DADOS     :=  IIF(::oWS_DADOS = NIL , NIL ,::oWS_DADOS:Clone() )
    oClone:lINSERECLIENTESRESULT := ::lINSERECLIENTESRESULT
    oClone:oWSLISTACLIENTESRESULT :=  IIF(::oWSLISTACLIENTESRESULT = NIL , NIL ,::oWSLISTACLIENTESRESULT:Clone() )
 
    // Estruturas mantidas por compatibilidade - NÃO USAR
    oClone:oWSCLIENTES   := oClone:oWS_DADOS
Return oClone
 
// WSDL Method INSERECLIENTES of Service WSEXEMPLOCT
 
WSMETHOD INSERECLIENTES WSSEND oWS_DADOS WSRECEIVE lINSERECLIENTESRESULT WSCLIENT WSEXEMPLOCT
Local cSoap := "" , oXmlRet
 
BEGIN WSMETHOD
 
cSoap += '<INSERECLIENTES xmlns="http://localhost/">'
cSoap += WSSoapValue("_DADOS", ::oWS_DADOS, oWS_DADOS , "CLIENTES", .T. , .F., 0 , NIL, .F.)
cSoap += "</INSERECLIENTES>"
 
oXmlRet := SvcSoapCall( Self,cSoap,;
    "http://localhost/INSERECLIENTES",;
    "DOCUMENT","http://localhost/",,"1.031217",;
    "http://localhost/EXEMPLOCT.apw")
 
::Init()
::lINSERECLIENTESRESULT :=  WSAdvValue( oXmlRet,"_INSERECLIENTESRESPONSE:_INSERECLIENTESRESULT:TEXT","boolean",NIL,NIL,NIL,NIL,NIL,NIL)
 
END WSMETHOD
 
oXmlRet := NIL
Return .T.
 
// WSDL Method LISTACLIENTES of Service WSEXEMPLOCT
 
WSMETHOD LISTACLIENTES WSSEND NULLPARAM WSRECEIVE oWSLISTACLIENTESRESULT WSCLIENT WSEXEMPLOCT
Local cSoap := "" , oXmlRet
 
BEGIN WSMETHOD
 
cSoap += '<LISTACLIENTES xmlns="http://localhost/">'
cSoap += "</LISTACLIENTES>"
 
oXmlRet := SvcSoapCall( Self,cSoap,;
    "http://localhost/LISTACLIENTES",;
    "DOCUMENT","http://localhost/",,"1.031217",;
    "http://localhost/EXEMPLOCT.apw")
 
::Init()
::oWSLISTACLIENTESRESULT:SoapRecv( WSAdvValue( oXmlRet,"_LISTACLIENTESRESPONSE:_LISTACLIENTESRESULT","CLIENTES",NIL,NIL,NIL,NIL,NIL,NIL) )
 
END WSMETHOD
 
oXmlRet := NIL
Return .T.
 
 
// WSDL Data Structure CLIENTES
 
WSSTRUCT EXEMPLOCT_CLIENTES
    WSDATA   oWSREGISTROS              AS EXEMPLOCT_ARRAYOFCLIENTE
    WSMETHOD NEW
    WSMETHOD INIT
    WSMETHOD CLONE
    WSMETHOD SOAPSEND
    WSMETHOD SOAPRECV
ENDWSSTRUCT
 
WSMETHOD NEW WSCLIENT EXEMPLOCT_CLIENTES
    ::Init()
Return Self
 
WSMETHOD INIT WSCLIENT EXEMPLOCT_CLIENTES
Return
 
WSMETHOD CLONE WSCLIENT EXEMPLOCT_CLIENTES
    Local oClone := EXEMPLOCT_CLIENTES():NEW()
    oClone:oWSREGISTROS         := IIF(::oWSREGISTROS = NIL , NIL , ::oWSREGISTROS:Clone() )
Return oClone
 
WSMETHOD SOAPSEND WSCLIENT EXEMPLOCT_CLIENTES
    Local cSoap := ""
    cSoap += WSSoapValue("REGISTROS", ::oWSREGISTROS, ::oWSREGISTROS , "ARRAYOFCLIENTE", .T. , .F., 0 , NIL, .F.)
Return cSoap
 
WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT EXEMPLOCT_CLIENTES
    Local oNode1
    ::Init()
    If oResponse = NIL ; Return ; Endif
    oNode1 :=  WSAdvValue( oResponse,"_REGISTROS","ARRAYOFCLIENTE",NIL,"Property oWSREGISTROS as s0:ARRAYOFCLIENTE on SOAP Response not found.",NIL,"O",NIL,NIL)
    If oNode1 != NIL
        ::oWSREGISTROS := EXEMPLOCT_ARRAYOFCLIENTE():New()
        ::oWSREGISTROS:SoapRecv(oNode1)
    EndIf
Return
 
// WSDL Data Structure ARRAYOFCLIENTE
 
WSSTRUCT EXEMPLOCT_ARRAYOFCLIENTE
    WSDATA   oWSCLIENTE                AS EXEMPLOCT_CLIENTE OPTIONAL
    WSMETHOD NEW
    WSMETHOD INIT
    WSMETHOD CLONE
    WSMETHOD SOAPSEND
    WSMETHOD SOAPRECV
ENDWSSTRUCT
 
WSMETHOD NEW WSCLIENT EXEMPLOCT_ARRAYOFCLIENTE
    ::Init()
Return Self
 
WSMETHOD INIT WSCLIENT EXEMPLOCT_ARRAYOFCLIENTE
    ::oWSCLIENTE           := {} // Array Of  EXEMPLOCT_CLIENTE():New()
Return
 
WSMETHOD CLONE WSCLIENT EXEMPLOCT_ARRAYOFCLIENTE
    Local oClone := EXEMPLOCT_ARRAYOFCLIENTE():NEW()
    oClone:oWSCLIENTE := NIL
    If ::oWSCLIENTE <> NIL
        oClone:oWSCLIENTE := {}
        aEval( ::oWSCLIENTE , { |x| aadd( oClone:oWSCLIENTE , x:Clone() ) } )
    Endif
Return oClone
 
WSMETHOD SOAPSEND WSCLIENT EXEMPLOCT_ARRAYOFCLIENTE
    Local cSoap := ""
    aEval( ::oWSCLIENTE , {|x| cSoap := cSoap  +  WSSoapValue("CLIENTE", x , x , "CLIENTE", .F. , .F., 0 , NIL, .F.)  } )
Return cSoap
 
WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT EXEMPLOCT_ARRAYOFCLIENTE
    Local nRElem1, oNodes1, nTElem1
    ::Init()
    If oResponse = NIL ; Return ; Endif
    oNodes1 :=  WSAdvValue( oResponse,"_CLIENTE","CLIENTE",{},NIL,.T.,"O",NIL,NIL)
    nTElem1 := len(oNodes1)
    For nRElem1 := 1 to nTElem1
        If !WSIsNilNode( oNodes1[nRElem1] )
            aadd(::oWSCLIENTE , EXEMPLOCT_CLIENTE():New() )
            ::oWSCLIENTE[len(::oWSCLIENTE)]:SoapRecv(oNodes1[nRElem1])
        Endif
    Next
Return
 
// WSDL Data Structure CLIENTE
 
WSSTRUCT EXEMPLOCT_CLIENTE
    WSDATA   cNOME                     AS string
    WSDATA   cTELEFONE                 AS string OPTIONAL
    WSMETHOD NEW
    WSMETHOD INIT
    WSMETHOD CLONE
    WSMETHOD SOAPSEND
    WSMETHOD SOAPRECV
ENDWSSTRUCT
 
WSMETHOD NEW WSCLIENT EXEMPLOCT_CLIENTE
    ::Init()
Return Self
 
WSMETHOD INIT WSCLIENT EXEMPLOCT_CLIENTE
Return
 
WSMETHOD CLONE WSCLIENT EXEMPLOCT_CLIENTE
    Local oClone := EXEMPLOCT_CLIENTE():NEW()
    oClone:cNOME                := ::cNOME
    oClone:cTELEFONE            := ::cTELEFONE
Return oClone
 
WSMETHOD SOAPSEND WSCLIENT EXEMPLOCT_CLIENTE
    Local cSoap := ""
    cSoap += WSSoapValue("NOME", ::cNOME, ::cNOME , "string", .T. , .F., 0 , NIL, .F.)
    cSoap += WSSoapValue("TELEFONE", ::cTELEFONE, ::cTELEFONE , "string", .F. , .F., 0 , NIL, .F.)
Return cSoap
 
WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT EXEMPLOCT_CLIENTE
    ::Init()
    If oResponse = NIL ; Return ; Endif
    ::cNOME              :=  WSAdvValue( oResponse,"_NOME","string",NIL,"Property cNOME as s:string on SOAP Response not found.",NIL,"S",NIL,NIL)
    ::cTELEFONE          :=  WSAdvValue( oResponse,"_TELEFONE","string",NIL,NIL,NIL,"S",NIL,NIL)
Return