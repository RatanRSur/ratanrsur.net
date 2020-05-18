module Main exposing (main)

import Html exposing (Html, div, text)
import List exposing (head, sortBy, sortWith, tail)
import Maybe exposing (withDefault)
import TypedSvg exposing (circle, svg)
import TypedSvg.Attributes exposing (cx, cy, height, r, width)
import TypedSvg.Core exposing (Svg)
import TypedSvg.Types exposing (Length(..), pc, px)


type alias Point =
    { x : Float
    , y : Float
    }


type alias Circle =
    { center : Point
    , radius : Float
    }


points : List Point
points =
    [ { x = 750, y = 200 }
    , { x = 450, y = 450 }
    , { x = 300, y = 200 }
    , { x = 20, y = 20 }
    ]


dot : Point -> Html.Html msg
dot center =
    circle [ cx (px center.x), cy (px center.y), r (px 5) ] []



-- see http://www.s-hull.org/paper/s_hull.pdf


euclidian : Point -> Point -> Float
euclidian p1 p2 =
    sqrt ((p1.x - p2.x) ^ 2 + (p1.y - p2.y) ^ 2)


circumcircle : Point -> Point -> Point -> Circle
circumcircle a b c =
    let
        d =
            1 / (2 * (a.x * (b.y - c.y) + b.x * (c.y - a.y) + c.x * (a.y - b.y)))

        center =
            { x = d * ((a.x ^ 2 + a.y ^ 2) * (b.y - c.y) + (b.x ^ 2 + b.y ^ 2) * (c.y - a.y) + (c.x ^ 2 + c.y ^ 2) * (a.y - b.y))
            , y = d * ((a.x ^ 2 + a.y ^ 2) * (c.x - b.x) + (b.x ^ 2 + b.y ^ 2) * (a.x - c.x) + (c.x ^ 2 + c.y ^ 2) * (b.x - a.x))
            }
    in
    { center = center
    , radius = euclidian a center
    }


main : Html a
main =
    let
        debug =
            Debug.log
                "smallest circle"
                (case points of
                    seedPoint :: secondPointCandidates ->
                        let
                            sortedByDistance =
                                sortBy (euclidian seedPoint) secondPointCandidates
                        in
                        case sortedByDistance of
                            closestPoint :: thirdPointCandidates ->
                                case head (sortBy (\otherPoint -> (circumcircle seedPoint closestPoint otherPoint).radius) thirdPointCandidates) of
                                    Just smallestCirclePoint ->
                                        [ seedPoint, closestPoint, smallestCirclePoint ]

                                    Nothing ->
                                        []

                            _ ->
                                []

                    _ ->
                        []
                )
    in
    div
        []
        [ svg [ height (pc 100), width (pc 100) ] (List.map dot points) ]