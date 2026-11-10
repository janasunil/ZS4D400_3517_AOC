CLASS zcl_3517_exception DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_3517_exception IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA: result TYPE i.
    CONSTANTS: c_text TYPE string VALUE 'ABC'.
    DATA numbers TYPE TABLE OF i.
    CONSTANTS: c_index TYPE i value 2.

    APPEND 123 TO numbers.

    TRY.
        result = c_text.
        out->write( |Converted content is { result }| ).
      CATCH cx_sy_conversion_no_number.
        out->write( |Error { c_text } is not a number| ).
    ENDTRY.

     TRY.
        result = 100 / 0.
      CATCH  cx_sy_zerodivide.
        out->write( `Division by Zero is not defined` ).
    ENDTRY.

    TRY.
        result = numbers[ c_index ].
        out->write( |Content of the row { c_index } equals { result }| ).
      CATCH cx_sy_itab_line_not_found.
        out->write( |Error: Itab has less than { c_index } rows| ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
