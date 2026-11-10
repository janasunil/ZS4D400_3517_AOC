CLASS zcl_3517_hello_world DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_3517_hello_world IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*  out->write( 'Hello World!!!' ).
   TYPES t_amount TYPE  p LENGTH 8 DECIMALS 2.

    DATA amount   TYPE t_amount VALUE '3.30'.
    DATA amount1  TYPE t_amount VALUE '1.20'.
    DATA amount2  TYPE t_amount VALUE '2.10'.

  DATA(text) = |Total Amount = { amount  +  amount1  + amount2 } EUR|.
  out->write( text ).
  ENDMETHOD.
ENDCLASS.
