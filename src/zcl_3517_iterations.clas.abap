CLASS zcl_3517_iterations DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_3517_iterations IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  DATA: numbers TYPE TABLE OF i,
        number TYPE i value 100.

  APPEND 1234 to numbers.
  APPEND 1234 * 2  to numbers.
  APPEND number to numbers.

*  number = numbers[ 2 ].
*  out->write( |Content of row 2: { number }| ).
*  out->write( |Content of row 1: { numbers[ 1 ] }| ).

  LOOP AT numbers INTO DATA(number_line).
  out->write( |Row: { sy-tabix } Content { number_line } | ).
  ENDLOOP.

  ENDMETHOD.
ENDCLASS.
