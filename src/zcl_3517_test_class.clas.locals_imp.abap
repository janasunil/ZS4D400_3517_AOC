*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lcl_connection DEFINITION.

  PUBLIC SECTION.
    TYPES: BEGIN OF ty_connection,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             carrier_name    TYPE /dmo/carrier_name,
           END OF ty_connection,
           BEGIN of ty_connection_nested,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             message TYPE symsg,
             carrier_name    TYPE /dmo/carrier_name,
           END of ty_connection_nested.
    DATA: connection TYPE ty_connection.
    DATA: connection_nested TYPE ty_connection_nested.

    CLASS-DATA: conn_counter TYPE i READ-ONLY.
    METHODS constructor IMPORTING carrier_id    TYPE /dmo/carrier_id
                                  connection_id TYPE /dmo/connection_id
                        RAISING   cx_abap_invalid_value.
    CLASS-METHODS class_constructor.
    METHODS:  set_attributes IMPORTING carrier_id    TYPE /dmo/carrier_id OPTIONAL
                                       connection_id TYPE /dmo/connection_id
                             RAISING   cx_abap_invalid_value,
      get_attributes EXPORTING carrier_id    TYPE /dmo/carrier_id
                               connection_id TYPE /dmo/connection_id,
      get_output RETURNING VALUE(r_output) TYPE string_table.
  PRIVATE SECTION.
    DATA: connection_id   TYPE /dmo/connection_id,
          carrier_id      TYPE /dmo/carrier_id,
          airport_from_id TYPE /dmo/airport_from_id,
          airport_to_id   TYPE /dmo/airport_to_id,
          carrier_name    TYPE /dmo/carrier_name.
    DATA: ls_connection TYPE /dmo/i_connection,
          message       TYPE symsg.
ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.
  METHOD Constructor.

    IF carrier_id IS INITIAL OR connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.
    me->carrier_id = carrier_id.
    me->connection_id = connection_id.
    conn_counter = conn_counter + 1.

*    connection-airport_from_id = 'ABC'.
*    connection-airport_to_id = 'XYZ'.
*    connection-carrier_name = 'Lufthansa'.

    connection = VALUE #( airport_from_id = 'ABC'
                            airport_to_id = 'XYZ'
                            carrier_name = 'Lufthansa' ).
    connection_nested = VALUE #( airport_from_id = 'ABC'
                                 airport_to_id = 'XYZ'
                                 message = VALUE #( msgty = 'E'
                                                    msgid = 'ABC'
                                                    msgno = '123' )
                                 carrier_name = 'Lufthansa' ).
*    SELECT SINGLE
*           FROM /dmo/connection
*           FIELDS airport_from_id,airport_to_id
*           WHERE carrier_id = @me->carrier_id
*           AND   connection_id = @me->connection_id
*           INTO ( @airport_from_id, @airport_to_id ).
    SELECT SINGLE
       FROM /dmo/I_Connection
       FIELDS DepartureAirport,DestinationAirport, \_Airline-Name
       WHERE AirlineID = @me->carrier_id
       AND   ConnectionID = @me->connection_id
       INTO ( @airport_from_id, @airport_to_id, @carrier_name ).
    SELECT SINGLE
       FROM /dmo/I_Connection
       FIELDS AirlineID,ConnectionID,DepartureAirport,
             DestinationAirport,DepartureTime,ArrivalTime,Distance,DistanceUnit
       WHERE AirlineID = @me->carrier_id
       AND   ConnectionID = @me->connection_id
       INTO @ls_connection.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

  ENDMETHOD.
  METHOD set_attributes.
    IF carrier_id IS INITIAL OR connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.
    me->carrier_id = carrier_id.
    me->connection_id = connection_id.
  ENDMETHOD.

  METHOD get_attributes.
    carrier_id = carrier_id.
    connection_id = connection_id.
  ENDMETHOD.

  METHOD get_output.
    APPEND |------------------------------| TO r_output.
    APPEND |Carrier:     { carrier_id    }| TO r_output.
    APPEND |Connection:  { connection_id }| TO r_output.
    APPEND |Departure:   { airport_from_id }| TO r_output.
    APPEND |Destination: { airport_to_id }| TO r_output.
    APPEND |CarrierName: { carrier_name }| TO r_output.

  ENDMETHOD.

  METHOD class_constructor.

  ENDMETHOD.

ENDCLASS.
