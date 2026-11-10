CLASS zcl_3517_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_3517_test IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
  TYPES: BEGIN of ty_airport,
           airportid TYPE /dmo/airport_id,
           name      TYPE /dmo/airport_name,
         END OF ty_airport.
  TYPES: tt_airports TYPE STANDARD TABLE OF ty_airport
                          WITH NON-UNIQUE KEY airportid.
  DATA: airports TYPE tt_airports.

  SELECT FROM /dmo/i_carrier
         FIELDS 'Airline' as Type, AirlineID as ID, Name
         WHERE CurrencyCode = 'GBP'
  UNION ALL
      SELECT FROM /DMO/I_Airport
           FIELDS 'Airport' AS Type, AirportID AS Id,  Name
           WHERE City = 'London'

    INTO TABLE @DATA(names).
    OUT->write( names ).
  ENDMETHOD.
ENDCLASS.
