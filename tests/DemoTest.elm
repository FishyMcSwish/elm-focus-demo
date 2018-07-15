module DemoTest exposing (..)

import Demo exposing (..)
import Expect exposing (Expectation)
import Focus exposing ((=>), Focus)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)


suite : Test
suite =
    describe "focus tests"
        [ test "get name from focus" <|
            \_ ->
                Focus.get nameFocus testCustomer
                    |> Expect.equal
                        "test customer"
        , test "get name regular" <|
            \_ ->
                testCustomer.name
                    |> Expect.equal
                        "test customer"
        , test "set name regular" <|
            \_ ->
                let
                    newCustomer =
                        { testCustomer | name = "Howard" }
                in
                newCustomer.name
                    |> Expect.equal
                        "Howard"
        , test "set name with focus" <|
            \_ ->
                let
                    newCustomer =
                        Focus.set nameFocus "Howard" testCustomer
                in
                newCustomer.name
                    |> Expect.equal
                        "Howard"
        , test "update with focus" <|
            \_ ->
                Focus.update ageFocus increment testCustomer
                    |> Expect.equal
                        { testCustomer | age = 31 }
        , test "update child with focus" <|
            \_ ->
                Focus.update ageFocus increment testChild
                    |> Expect.equal
                        { testChild | age = 2 }
        , test "nested update without focus" <|
            \_ ->
                let
                    newChild =
                        { testChild | age = 3 }

                    newParent =
                        { testCustomer | child = newChild }
                in
                Expect.equal newParent.child.age 3
        , test "nested update with focus" <|
            \_ ->
                let
                    newParent =
                        Focus.set (childFocus => ageFocus) 3 testCustomer
                in
                Expect.equal newParent.child.age 3
        ]


increment : Int -> Int
increment num =
    num + 1


testCustomer : Customer
testCustomer =
    { child = testChild
    , name = "test customer"
    , latePayments = 0
    , favoriteFlower = "Rose"
    , age = 30
    }


testChild : Child
testChild =
    { name = "testChild"
    , age = 1
    , favoriteColor = "blue"
    }
