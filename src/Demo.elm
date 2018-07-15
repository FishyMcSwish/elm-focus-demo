module Demo exposing (..)

import Focus exposing (Focus)


type alias Customer =
    { child : Child
    , name : String
    , latePayments : Int
    , favoriteFlower : String
    , age : Int
    }


type alias Child =
    { name : String
    , age : Int
    , favoriteColor : String
    }


ageFocus : Focus { a | age : Int } Int
ageFocus =
    Focus.create
        .age
        anonymousFunc


anonymousFunc : (Int -> Int) -> { a | age : Int } -> { a | age : Int }
anonymousFunc func customer =
    { customer | age = func customer.age }


nameFocus : Focus Customer String
nameFocus =
    Focus.create
        .name
        (\func customer ->
            { customer | name = func customer.name }
        )


childFocus : Focus Customer Child
childFocus =
    Focus.create
        .child
        (\func customer ->
            { customer | child = func customer.child }
        )
