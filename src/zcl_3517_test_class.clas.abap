CLASS zcl_3517_test_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_3517_test_class IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA: connection  TYPE REF TO lcl_connection.

  TRY.
    connection = NEW lcl_connection( carrier_id = 'LH' connection_id = '0400' ).
    CATCH cx_abap_invalid_value.
  ENDTRY.

    TRY.
      connection->set_attributes( carrier_id = 'LH' connection_id = '0400'  ).
     out->write( 'Method call successfull' ).
      CATCH cx_abap_invalid_value.
     out->write( 'Method call not success' ).
    ENDTRY.


*    CATCH cx_abap_invalid_value.

*    DATA(result) = connection->get_output( )..
*     out->write( result ).
    out->write(
      EXPORTING
        data   =  connection->get_output( )
        name   =  `Display`
*      RECEIVING
*        output =
    ).


*    connection->get_attributes(
*      IMPORTING
*        carrier_id    = connection->carrier_id
*        connection_id = connection->connection_id
*    ).
  ENDMETHOD.
ENDCLASS.
