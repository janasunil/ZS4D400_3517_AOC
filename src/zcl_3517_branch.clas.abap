CLASS zcl_3517_branch DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_3517_branch IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA: number1 TYPE i,
          number2 TYPE i,
          result  TYPE p LENGTH 8 DECIMALS 2,
          op      TYPE c LENGTH 1,
          output  TYPE string.

    number1 = 123.
    number2 = 0.
    op = '/'.

    CASE op.
      WHEN '+'.
        result = number1 + number2.
      WHEN '-'.
        result = number1 - number2.
      WHEN '*'.
        result = number1 * number2.
      WHEN '/'.
        TRY.
            result = number1 / number2.
          CATCH cx_sy_zerodivide.
           output = |Division by zero is not defined|.
        ENDTRY.
      WHEN OTHERS.
        output = |'{ op }' is not valid operator!!|.
    ENDCASE.

    IF output IS INITIAL.
      output = |{ number1 } { op } { number2 } = { result }|.
    ENDIF.
    out->write( output ).
  ENDMETHOD.
ENDCLASS.
