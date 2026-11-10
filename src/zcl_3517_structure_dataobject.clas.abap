CLASS zcl_3517_structure_dataobject DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF ty_connection,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             carrier_name    TYPE /dmo/carrier_name,
           END OF ty_connection.
    TYPES: BEGIN OF ty_nested_connection,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             message         TYPE symsg,
             carrier_name    TYPE /dmo/carrier_name,
           END OF ty_nested_connection.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_3517_structure_dataobject IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA: connection        TYPE ty_connection,
          connection_nested TYPE ty_nested_connection.
*    connection-airport_from_id = 'FRA'.
*    connection-airport_to_id = 'JFK'.
*    connection-carrier_name = 'Lufthansa'.

    connection = VALUE #( airport_from_id = 'FRA'
                          airport_to_id = 'JFK'
                          carrier_name = 'Lufthansa' ).
    connection_nested = CORRESPONDING #( connection ).
    connection = VALUE #(  ).

    SELECT SINGLE
           FROM /dmo/i_connection
           FIELDS AirlineID,ConnectionID,DepartureAirport,DestinationAirport, \_Airline-Name
           WHERE AirlineID = 'LH' AND ConnectionID = '0400'
           INTO @DATA(connections).
    out->write( connections ).

    SELECT SINGLE
           FROM /dmo/connection AS a
           LEFT OUTER JOIN /dmo/airport AS b
           ON a~airport_from_id = b~airport_id
           FIELDS a~carrier_id,a~connection_id,
                  a~airport_from_id,a~airport_to_id,
                  b~name
           WHERE carrier_id = 'LH' AND connection_id = '0400'
           INTO @DATA(output).

    out->write( output ).

    SELECT SINGLE
        FROM  /dmo/connection AS a
               LEFT OUTER JOIN /dmo/airport AS b
              ON a~airport_from_id = b~airport_id

             LEFT OUTER JOIN  /dmo/airport AS c
             ON a~airport_to_id = c~airport_id
        FIELDS a~carrier_id,a~connection_id,
               a~airport_from_id,a~airport_to_id,
               b~name AS AirportDepartureName,
               c~name AS AirportArrivalName
        WHERE carrier_id = 'LH' AND connection_id = '0400'
        INTO @DATA(outputs).

    out->write( outputs ).
  ENDMETHOD.
ENDCLASS.
