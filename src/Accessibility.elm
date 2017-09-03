module Accessibility
    exposing
        ( Html
        , a
        , abbr
        , address
        , article
        , aside
        , audio
        , b
        , bdi
        , bdo
        , blockquote
        , body
        , br
        , button
        , canvas
        , caption
        , checkBoxInvisibleLabel
        , checkBoxLeftLabeled
        , checkBoxRightLabeled
        , cite
        , code
        , col
        , colgroup
        , datalist
        , dd
        , decorativeImg
        , del
        , details
        , dfn
        , div
        , dl
        , dt
        , em
        , embed
        , fieldset
        , figcaption
        , figure
        , footer
        , form
        , h1
        , h2
        , h3
        , h4
        , h5
        , h6
        , header
        , hr
        , i
        , iframe
        , img
        , ins
        , kbd
        , keygen
        , label
        , legend
        , li
        , main_
        , mark
        , math
        , menu
        , menuitem
        , meter
        , nav
        , object
        , ol
        , optgroup
        , option
        , output
        , p
        , param
        , pre
        , progress
        , q
        , radioInvisibleLabel
        , radioLeftLabeled
        , radioRightLabeled
        , rp
        , rt
        , ruby
        , s
        , samp
        , section
        , select
        , small
        , source
        , span
        , strong
        , sub
        , summary
        , sup
        , tab
        , tabList
        , tabPanel
        , table
        , tbody
        , td
        , text
        , textInvisibleLabel
        , textLeftLabeled
        , textRightLabeled
        , textarea
        , tfoot
        , th
        , thead
        , time
        , tr
        , track
        , u
        , ul
        , var
        , video
        , wbr
        )

{-|


## Inputs

Inputs defined in this library are offered in three varieties: left-labeled, right-labeled, and featuring an invisible-label.
Invisible-labeled views require an id.


### Text Inputs

@docs textLeftLabeled, textRightLabeled, textInvisibleLabel


### Radio Inputs

@docs radioLeftLabeled, radioRightLabeled, radioInvisibleLabel


### CheckBox Inputs

@docs checkBoxLeftLabeled, checkBoxRightLabeled, checkBoxInvisibleLabel


## Tabs

Together, `tabList`, `tab`, and `tabPanel` describe the pieces of a tab component view.

    import Html exposing (text)
    import Html.A11y exposing (tab, tabList, tabPanel)
    import Html.Attributes
    import Html.Attributes.A11y as A11yAttributes

    view : Html msg
    view =
        tabList
            [ id "tab-list" ]
            [ tab
                [ id "tab-1"
                , A11yAttributes.selected True
                , A11yAttributes.controls "panel-1"
                ]
                [ text "Tab One" ]
            , tab
                [ id "tab-2"
                , A11yAttributes.selected False
                , A11yAttributes.controls "panel-1"
                ]
                [ text "Tab Two" ]
            , tabPanel
                [ id "panel-1"
                , A11yAttributes.labelledBy "tab-1"
                , A11yAttributes.hidden False
                , Html.Attributes.hidden False
                ]
                [ text "Panel One Content" ]
            , tabPanel
                [ id "panel-2"
                , A11yAttributes.labelledBy "tab-2"
                , A11yAttributes.hidden True
                , Html.Attributes.hidden True
                ]
                [ text "Panel Two Content" ]
            ]

For a more fully-fledged example using these helpers check out [elm-tabs](http://package.elm-lang.org/packages/tesk9/elm-tabs/latest).

@docs tabList, tab, tabPanel


## Images

@docs img, decorativeImg, figure


## From Html

@docs Html, text


### Interactable elements

@docs button, textarea, select


### Non-interactable elements

@docs h1, h2, h3, h4, h5, h6
@docs div, p, hr, pre, blockquote
@docs span, a, code, em, strong, i, b, u, sub, sup, br
@docs ol, ul, li, dl, dt, dd
@docs img, iframe, canvas, math
@docs form, option
@docs section, nav, article, aside, header, footer, address, main_, body
@docs figure, figcaption
@docs table, caption, colgroup, col, tbody, thead, tfoot, tr, td, th
@docs fieldset, legend, label, datalist, optgroup, keygen, output, progress, meter
@docs audio, video, source, track
@docs embed, object, param
@docs ins, del
@docs small, cite, dfn, abbr, time, var, samp, kbd, s, q
@docs mark, ruby, rt, rp, bdi, bdo, wbr
@docs details, summary, menuitem, menu

-}

import Accessibility.Role as Role
import Accessibility.Style as Style
import Accessibility.Widget as Widget
import Html
import Html.Attributes


{- *** Text Inputs *** -}


textModel : String -> List (Html.Attribute msg) -> Html msg -> Input msg
textModel value attributes label =
    { typeAndValue = textInput value
    , label = label
    , attributes = attributes
    }


{-| Construct a left-labeled text input.

    textLeftLabeled "This appears in the text input." [] <| text "I'm the label!"

-}
textLeftLabeled : String -> List (Html.Attribute msg) -> Html msg -> Html msg
textLeftLabeled value attributes label =
    leftLabeledInput (textModel value attributes label)


{-| Construct a right-labeled text input.

    textRightLabeled "This appears in the text input." [] <| text "I'm the label!"

-}
textRightLabeled : String -> List (Html.Attribute msg) -> Html msg -> Html msg
textRightLabeled value attributes label =
    rightLabeledInput (textModel value attributes label)


{-| Construct a text input with an invisible label.

    textInvisibleLabel "best-input-everrr" "This appears in the text input." [] <| text "I'm the label!"

-}
textInvisibleLabel : String -> String -> List (Html.Attribute msg) -> Html msg -> Html msg
textInvisibleLabel id value attributes label =
    invisibleLabeledInput (textModel value attributes label) id



{- *** Radio Inputs *** -}


radioModel : String -> String -> Bool -> List (Html.Attribute msg) -> Html msg -> Input msg
radioModel groupName value checked attributes label =
    { typeAndValue = radioInput groupName value checked
    , label = label
    , attributes = attributes
    }


{-| Construct a left-labeled radio input.

    radioLeftLabeled "radio_name" "This is the actual value of the radio." True [] <| text "I'm the label!"

-}
radioLeftLabeled : String -> String -> Bool -> List (Html.Attribute msg) -> Html msg -> Html msg
radioLeftLabeled groupName value checked attributes label =
    leftLabeledInput (radioModel groupName value checked attributes label)


{-| Construct a right-labeled radio input.

    radioRightLabeled  "radio_name" "This is the actual value of the radio." True [] <| text "I'm the label!"

-}
radioRightLabeled : String -> String -> Bool -> List (Html.Attribute msg) -> Html msg -> Html msg
radioRightLabeled groupName value checked attributes label =
    rightLabeledInput (radioModel groupName value checked attributes label)


{-| Construct a radio button with an invisible label.

    radioInvisibleLabel "best-input-everrr" "This is the actual value of the radio." [] <| text "I'm the label!"

-}
radioInvisibleLabel : String -> String -> String -> Bool -> List (Html.Attribute msg) -> Html msg -> Html msg
radioInvisibleLabel id groupName value checked attributes label =
    invisibleLabeledInput (radioModel groupName value checked attributes label) id



{- *** Checkbox Inputs *** -}


checkBoxModel : String -> Maybe Bool -> List (Html.Attribute msg) -> Html msg -> Input msg
checkBoxModel value checked attributes label =
    { typeAndValue = checkboxInput value checked
    , label = label
    , attributes = attributes
    }


{-| Construct a left-labeled check box input.

    checkBoxLeftLabeled "This is the actual value of the check box." (Just True) [] <| text "I'm the label!"

-}
checkBoxLeftLabeled : String -> Maybe Bool -> List (Html.Attribute msg) -> Html msg -> Html msg
checkBoxLeftLabeled value checked attributes label =
    leftLabeledInput (checkBoxModel value checked attributes label)


{-| Construct a right-labeled check box input.

    checkBoxRightLabeled  "This is the actual value of the checkBox." (Just True) [] <| text "I'm the label!"

-}
checkBoxRightLabeled : String -> Maybe Bool -> List (Html.Attribute msg) -> Html msg -> Html msg
checkBoxRightLabeled value checked attributes label =
    rightLabeledInput (checkBoxModel value checked attributes label)


{-| Construct a check box with an invisible label.

    checkBoxInvisibleLabel "checkbox-id" "Checkbox value" (Just False) [] <| text "I'm the label!"

-}
checkBoxInvisibleLabel : String -> String -> Maybe Bool -> List (Html.Attribute msg) -> Html msg -> Html msg
checkBoxInvisibleLabel id value checked attributes label =
    invisibleLabeledInput (checkBoxModel value checked attributes label) id



-- INPUT HELPERS


type alias Input msg =
    { label : Html msg
    , typeAndValue : InputTypeAndValue
    , attributes : List (Html.Attribute msg)
    }


type InputTypeAndValue
    = Text String
    | Radio String String Bool
    | Checkbox String (Maybe Bool)


textInput : String -> InputTypeAndValue
textInput =
    Text


radioInput : String -> String -> Bool -> InputTypeAndValue
radioInput =
    Radio


checkboxInput : String -> Maybe Bool -> InputTypeAndValue
checkboxInput =
    Checkbox


typeAndValueAttibutes : InputTypeAndValue -> List (Html.Attribute msg)
typeAndValueAttibutes typeAndValue =
    case typeAndValue of
        Text value_ ->
            [ Html.Attributes.type_ "text"
            , Html.Attributes.value value_
            ]

        Radio name_ value_ checked_ ->
            [ Html.Attributes.type_ "radio"
            , Html.Attributes.name name_
            , Html.Attributes.value value_
            , Html.Attributes.checked checked_
            ]

        Checkbox value_ maybe_checked ->
            [ Html.Attributes.type_ "checkbox"
            , Html.Attributes.value value_
            , Maybe.withDefault Widget.indeterminate (Maybe.map Html.Attributes.checked maybe_checked)
            ]


baseInput : Input msg -> Html msg
baseInput inputModel =
    Html.input (typeAndValueAttibutes inputModel.typeAndValue ++ inputModel.attributes) []


leftLabeledInput : Input msg -> Html msg
leftLabeledInput inputModel =
    Html.label
        []
        [ inputModel.label
        , baseInput inputModel
        ]


rightLabeledInput : Input msg -> Html msg
rightLabeledInput inputModel =
    Html.label
        []
        [ baseInput inputModel
        , inputModel.label
        ]


invisibleLabeledInput : Input msg -> String -> Html msg
invisibleLabeledInput inputModel id_ =
    Html.span
        []
        [ Html.label [ Style.invisible, Html.Attributes.for id_ ] [ inputModel.label ]
        , Html.input
            (typeAndValueAttibutes inputModel.typeAndValue
                ++ Html.Attributes.id id_
                :: inputModel.attributes
            )
            []
        ]



{- *** Tabs *** -}


{-| Create a tablist. This is the outer container for a list of tabs.
-}
tabList : List (Html.Attribute msg) -> List (Html msg) -> Html msg
tabList attributes =
    Html.div (Role.tabList :: attributes)


{-| Create a tab. This is the part that you select in order to change panel views.
-}
tab : List (Html.Attribute msg) -> List (Html msg) -> Html msg
tab attributes =
    Html.div (Role.tab :: Html.Attributes.tabindex 0 :: attributes)


{-| Create a tab panel.

    tabPanel [] [ h3 [] [ text "Panel Header" ], text "Panel Content" ]

-}
tabPanel : List (Html.Attribute msg) -> List (Html msg) -> Html msg
tabPanel attributes =
    Html.div (Role.tabPanel :: attributes)



{- *** Images *** -}


{-| Use this tag when the image provides information not expressed in the text of the page.
When images are used to express the purpose of a button or link, aim for alternative text that encapsulates the function of the image.

Read through [the w3 informative image tutorial](https://www.w3.org/WAI/tutorials/images/informative/) and the [the w3 functional image tutorial](https://www.w3.org/WAI/tutorials/images/functional/) to learn more.

For graphs and diagrams, see `figure` and `longDesc`.

    img "Bear rubbing back on tree" [ src "bear.png" ]

-}
img : String -> List (Html.Attribute msg) -> Html msg
img alt_ attributes =
    Html.img (Html.Attributes.alt alt_ :: attributes) []


{-| Use this tag when the image is decorative or provides redundant information. Read through [the w3 decorative image tutorial](https://www.w3.org/WAI/tutorials/images/decorative/) to learn more.

    decorativeImg [ src "smiling_family.jpg" ]

-}
decorativeImg : List (Html.Attribute msg) -> Html msg
decorativeImg attributes =
    Html.img (Html.Attributes.alt "" :: Role.presentation :: attributes) []


{-| Adds the group role to a figure.
-}
figure : List (Html.Attribute msg) -> List (Html msg) -> Html msg
figure attributes =
    Html.figure (Role.group :: attributes)



{- *** Aliasing Html Elements *** -}


{-| -}
type alias Html msg =
    Html.Html msg


{-| -}
text : String -> Html.Html msg
text =
    Html.text



-- INTERACTABLE


{-| -}
select : List (Html.Attribute msg) -> List (Html msg) -> Html msg
select =
    Html.select


{-| -}
button : List (Html.Attribute msg) -> List (Html msg) -> Html msg
button =
    Html.button



-- NOT INTERACTABLE


{-| `body` should generally not have event listeners.
-}
body : List (Html.Attribute Never) -> List (Html msg) -> Html msg
body attributes =
    Html.body (List.map (Html.Attributes.map Basics.never) attributes)


{-| `section` should generally not have event listeners.
-}
section : List (Html.Attribute Never) -> List (Html msg) -> Html msg
section attributes =
    Html.section (List.map (Html.Attributes.map Basics.never) attributes)


{-| `nav` should generally not have event listeners.
-}
nav : List (Html.Attribute Never) -> List (Html msg) -> Html msg
nav attributes =
    Html.nav (List.map (Html.Attributes.map Basics.never) attributes)


{-| `article` should generally not have event listeners.
-}
article : List (Html.Attribute Never) -> List (Html msg) -> Html msg
article attributes =
    Html.article (List.map (Html.Attributes.map Basics.never) attributes)


{-| `aside` should generally not have event listeners.
-}
aside : List (Html.Attribute Never) -> List (Html msg) -> Html msg
aside attributes =
    Html.aside (List.map (Html.Attributes.map Basics.never) attributes)


{-| `h1` should generally not have event listeners.
-}
h1 : List (Html.Attribute Never) -> List (Html msg) -> Html msg
h1 attributes =
    Html.h1 (List.map (Html.Attributes.map Basics.never) attributes)


{-| `h2` should generally not have event listeners.
-}
h2 : List (Html.Attribute Never) -> List (Html msg) -> Html msg
h2 attributes =
    Html.h2 (List.map (Html.Attributes.map Basics.never) attributes)


{-| `h3` should generally not have event listeners.
-}
h3 : List (Html.Attribute Never) -> List (Html msg) -> Html msg
h3 attributes =
    Html.h3 (List.map (Html.Attributes.map Basics.never) attributes)


{-| `h4` should generally not have event listeners.
-}
h4 : List (Html.Attribute Never) -> List (Html msg) -> Html msg
h4 attributes =
    Html.h4 (List.map (Html.Attributes.map Basics.never) attributes)


{-| `h5` should generally not have event listeners.
-}
h5 : List (Html.Attribute Never) -> List (Html msg) -> Html msg
h5 attributes =
    Html.h5 (List.map (Html.Attributes.map Basics.never) attributes)


{-| `h6` should generally not have event listeners.
-}
h6 : List (Html.Attribute Never) -> List (Html msg) -> Html msg
h6 attributes =
    Html.h6 (List.map (Html.Attributes.map Basics.never) attributes)


{-| `header` should generally not have event listeners.
-}
header : List (Html.Attribute Never) -> List (Html msg) -> Html msg
header attributes =
    Html.header (List.map (Html.Attributes.map Basics.never) attributes)


{-| `footer` should generally not have event listeners.
-}
footer : List (Html.Attribute Never) -> List (Html msg) -> Html msg
footer attributes =
    Html.footer (List.map (Html.Attributes.map Basics.never) attributes)


{-| `address` should generally not have event listeners.
-}
address : List (Html.Attribute Never) -> List (Html msg) -> Html msg
address attributes =
    Html.address (List.map (Html.Attributes.map Basics.never) attributes)


{-| `main_` should generally not have event listeners.
-}
main_ : List (Html.Attribute Never) -> List (Html msg) -> Html msg
main_ attributes =
    Html.main_ (List.map (Html.Attributes.map Basics.never) attributes)



-- GROUPING CONTENT


{-| `p` should generally not have event listeners.
-}
p : List (Html.Attribute Never) -> List (Html msg) -> Html msg
p attributes =
    Html.p (List.map (Html.Attributes.map Basics.never) attributes)


{-| `hr` should generally not have event listeners.
-}
hr : List (Html.Attribute Never) -> List (Html msg) -> Html msg
hr attributes =
    Html.hr (List.map (Html.Attributes.map Basics.never) attributes)


{-| `pre` should generally not have event listeners.
-}
pre : List (Html.Attribute Never) -> List (Html msg) -> Html msg
pre attributes =
    Html.pre (List.map (Html.Attributes.map Basics.never) attributes)


{-| `blockquote` should generally not have event listeners.
-}
blockquote : List (Html.Attribute Never) -> List (Html msg) -> Html msg
blockquote attributes =
    Html.blockquote (List.map (Html.Attributes.map Basics.never) attributes)


{-| `ol` should generally not have event listeners.
-}
ol : List (Html.Attribute Never) -> List (Html msg) -> Html msg
ol attributes =
    Html.ol (List.map (Html.Attributes.map Basics.never) attributes)


{-| `ul` should generally not have event listeners.
-}
ul : List (Html.Attribute Never) -> List (Html msg) -> Html msg
ul attributes =
    Html.ul (List.map (Html.Attributes.map Basics.never) attributes)


{-| `li` should generally not have event listeners.
-}
li : List (Html.Attribute Never) -> List (Html msg) -> Html msg
li attributes =
    Html.li (List.map (Html.Attributes.map Basics.never) attributes)


{-| `dl` should generally not have event listeners.
-}
dl : List (Html.Attribute Never) -> List (Html msg) -> Html msg
dl attributes =
    Html.dl (List.map (Html.Attributes.map Basics.never) attributes)


{-| `dt` should generally not have event listeners.
-}
dt : List (Html.Attribute Never) -> List (Html msg) -> Html msg
dt attributes =
    Html.dt (List.map (Html.Attributes.map Basics.never) attributes)


{-| `dd` should generally not have event listeners.
-}
dd : List (Html.Attribute Never) -> List (Html msg) -> Html msg
dd attributes =
    Html.dd (List.map (Html.Attributes.map Basics.never) attributes)


{-| `figcaption` should generally not have event listeners.
-}
figcaption : List (Html.Attribute Never) -> List (Html msg) -> Html msg
figcaption attributes =
    Html.figcaption (List.map (Html.Attributes.map Basics.never) attributes)


{-| `div` should generally not have event listeners.
-}
div : List (Html.Attribute Never) -> List (Html msg) -> Html msg
div attributes =
    Html.div (List.map (Html.Attributes.map Basics.never) attributes)



-- TEXT LEVEL SEMANTIC


{-| `:` should generally not have event listeners.
-}
a : List (Html.Attribute Never) -> List (Html msg) -> Html msg
a attributes =
    Html.a (List.map (Html.Attributes.map Basics.never) attributes)


{-| `em` should generally not have event listeners.
-}
em : List (Html.Attribute Never) -> List (Html msg) -> Html msg
em attributes =
    Html.em (List.map (Html.Attributes.map Basics.never) attributes)


{-| `strong` should generally not have event listeners.
-}
strong : List (Html.Attribute Never) -> List (Html msg) -> Html msg
strong attributes =
    Html.strong (List.map (Html.Attributes.map Basics.never) attributes)


{-| `small` should generally not have event listeners.
-}
small : List (Html.Attribute Never) -> List (Html msg) -> Html msg
small attributes =
    Html.small (List.map (Html.Attributes.map Basics.never) attributes)


{-| `s` should generally not have event listeners.
-}
s : List (Html.Attribute Never) -> List (Html msg) -> Html msg
s attributes =
    Html.s (List.map (Html.Attributes.map Basics.never) attributes)


{-| `cite` should generally not have event listeners.
-}
cite : List (Html.Attribute Never) -> List (Html msg) -> Html msg
cite attributes =
    Html.cite (List.map (Html.Attributes.map Basics.never) attributes)


{-| `q` should generally not have event listeners.
-}
q : List (Html.Attribute Never) -> List (Html msg) -> Html msg
q attributes =
    Html.q (List.map (Html.Attributes.map Basics.never) attributes)


{-| `dfn` should generally not have event listeners.
-}
dfn : List (Html.Attribute Never) -> List (Html msg) -> Html msg
dfn attributes =
    Html.dfn (List.map (Html.Attributes.map Basics.never) attributes)


{-| `abbr` should generally not have event listeners.
-}
abbr : List (Html.Attribute Never) -> List (Html msg) -> Html msg
abbr attributes =
    Html.abbr (List.map (Html.Attributes.map Basics.never) attributes)


{-| `time` should generally not have event listeners.
-}
time : List (Html.Attribute Never) -> List (Html msg) -> Html msg
time attributes =
    Html.time (List.map (Html.Attributes.map Basics.never) attributes)


{-| `code` should generally not have event listeners.
-}
code : List (Html.Attribute Never) -> List (Html msg) -> Html msg
code attributes =
    Html.code (List.map (Html.Attributes.map Basics.never) attributes)


{-| `var` should generally not have event listeners.
-}
var : List (Html.Attribute Never) -> List (Html msg) -> Html msg
var attributes =
    Html.var (List.map (Html.Attributes.map Basics.never) attributes)


{-| `samp` should generally not have event listeners.
-}
samp : List (Html.Attribute Never) -> List (Html msg) -> Html msg
samp attributes =
    Html.samp (List.map (Html.Attributes.map Basics.never) attributes)


{-| `kbd` should generally not have event listeners.
-}
kbd : List (Html.Attribute Never) -> List (Html msg) -> Html msg
kbd attributes =
    Html.kbd (List.map (Html.Attributes.map Basics.never) attributes)


{-| `sub` should generally not have event listeners.
-}
sub : List (Html.Attribute Never) -> List (Html msg) -> Html msg
sub attributes =
    Html.sub (List.map (Html.Attributes.map Basics.never) attributes)


{-| `sup` should generally not have event listeners.
-}
sup : List (Html.Attribute Never) -> List (Html msg) -> Html msg
sup attributes =
    Html.sup (List.map (Html.Attributes.map Basics.never) attributes)


{-| `i` should generally not have event listeners.
-}
i : List (Html.Attribute Never) -> List (Html msg) -> Html msg
i attributes =
    Html.i (List.map (Html.Attributes.map Basics.never) attributes)


{-| `b` should generally not have event listeners.
-}
b : List (Html.Attribute Never) -> List (Html msg) -> Html msg
b attributes =
    Html.b (List.map (Html.Attributes.map Basics.never) attributes)


{-| `u` should generally not have event listeners.
-}
u : List (Html.Attribute Never) -> List (Html msg) -> Html msg
u attributes =
    Html.u (List.map (Html.Attributes.map Basics.never) attributes)


{-| `mark` should generally not have event listeners.
-}
mark : List (Html.Attribute Never) -> List (Html msg) -> Html msg
mark attributes =
    Html.mark (List.map (Html.Attributes.map Basics.never) attributes)


{-| `ruby` should generally not have event listeners.
-}
ruby : List (Html.Attribute Never) -> List (Html msg) -> Html msg
ruby attributes =
    Html.ruby (List.map (Html.Attributes.map Basics.never) attributes)


{-| `rt` should generally not have event listeners.
-}
rt : List (Html.Attribute Never) -> List (Html msg) -> Html msg
rt attributes =
    Html.rt (List.map (Html.Attributes.map Basics.never) attributes)


{-| `rp` should generally not have event listeners.
-}
rp : List (Html.Attribute Never) -> List (Html msg) -> Html msg
rp attributes =
    Html.rp (List.map (Html.Attributes.map Basics.never) attributes)


{-| `bdi` should generally not have event listeners.
-}
bdi : List (Html.Attribute Never) -> List (Html msg) -> Html msg
bdi attributes =
    Html.bdi (List.map (Html.Attributes.map Basics.never) attributes)


{-| `bdo` should generally not have event listeners.
-}
bdo : List (Html.Attribute Never) -> List (Html msg) -> Html msg
bdo attributes =
    Html.bdo (List.map (Html.Attributes.map Basics.never) attributes)


{-| `span` should generally not have event listeners.
-}
span : List (Html.Attribute Never) -> List (Html msg) -> Html msg
span attributes =
    Html.span (List.map (Html.Attributes.map Basics.never) attributes)


{-| `br` should generally not have event listeners.
-}
br : List (Html.Attribute Never) -> Html Never
br attributes =
    Html.br (List.map (Html.Attributes.map Basics.never) attributes) []


{-| `wbr` should generally not have event listeners.
-}
wbr : List (Html.Attribute Never) -> List (Html msg) -> Html msg
wbr attributes =
    Html.wbr (List.map (Html.Attributes.map Basics.never) attributes)


{-| `ins` should generally not have event listeners.
-}
ins : List (Html.Attribute Never) -> List (Html msg) -> Html msg
ins attributes =
    Html.ins (List.map (Html.Attributes.map Basics.never) attributes)


{-| `del` should generally not have event listeners.
-}
del : List (Html.Attribute Never) -> List (Html msg) -> Html msg
del attributes =
    Html.del (List.map (Html.Attributes.map Basics.never) attributes)


{-| `iframe` should generally not have event listeners.
-}
iframe : List (Html.Attribute Never) -> List (Html msg) -> Html msg
iframe attributes =
    Html.iframe (List.map (Html.Attributes.map Basics.never) attributes)


{-| `embed` should generally not have event listeners.
-}
embed : List (Html.Attribute Never) -> List (Html msg) -> Html msg
embed attributes =
    Html.embed (List.map (Html.Attributes.map Basics.never) attributes)


{-| `object` should generally not have event listeners.
-}
object : List (Html.Attribute Never) -> List (Html msg) -> Html msg
object attributes =
    Html.object (List.map (Html.Attributes.map Basics.never) attributes)


{-| `param` should generally not have event listeners.
-}
param : List (Html.Attribute Never) -> List (Html msg) -> Html msg
param attributes =
    Html.param (List.map (Html.Attributes.map Basics.never) attributes)


{-| `video` should generally not have event listeners.
-}
video : List (Html.Attribute Never) -> List (Html msg) -> Html msg
video attributes =
    Html.video (List.map (Html.Attributes.map Basics.never) attributes)


{-| `audio` should generally not have event listeners.
-}
audio : List (Html.Attribute Never) -> List (Html msg) -> Html msg
audio attributes =
    Html.audio (List.map (Html.Attributes.map Basics.never) attributes)


{-| `source` should generally not have event listeners.
-}
source : List (Html.Attribute Never) -> List (Html msg) -> Html msg
source attributes =
    Html.source (List.map (Html.Attributes.map Basics.never) attributes)


{-| `track` should generally not have event listeners.
-}
track : List (Html.Attribute Never) -> List (Html msg) -> Html msg
track attributes =
    Html.track (List.map (Html.Attributes.map Basics.never) attributes)


{-| `canvas` should generally not have event listeners.
-}
canvas : List (Html.Attribute Never) -> List (Html msg) -> Html msg
canvas attributes =
    Html.canvas (List.map (Html.Attributes.map Basics.never) attributes)


{-| `math` should generally not have event listeners.
-}
math : List (Html.Attribute Never) -> List (Html msg) -> Html msg
math attributes =
    Html.math (List.map (Html.Attributes.map Basics.never) attributes)


{-| `table` should generally not have event listeners.
-}
table : List (Html.Attribute Never) -> List (Html msg) -> Html msg
table attributes =
    Html.table (List.map (Html.Attributes.map Basics.never) attributes)


{-| `caption` should generally not have event listeners.
-}
caption : List (Html.Attribute Never) -> List (Html msg) -> Html msg
caption attributes =
    Html.caption (List.map (Html.Attributes.map Basics.never) attributes)


{-| `colgroup` should generally not have event listeners.
-}
colgroup : List (Html.Attribute Never) -> List (Html msg) -> Html msg
colgroup attributes =
    Html.colgroup (List.map (Html.Attributes.map Basics.never) attributes)


{-| `col` should generally not have event listeners.
-}
col : List (Html.Attribute Never) -> List (Html msg) -> Html msg
col attributes =
    Html.col (List.map (Html.Attributes.map Basics.never) attributes)


{-| `tbody` should generally not have event listeners.
-}
tbody : List (Html.Attribute Never) -> List (Html msg) -> Html msg
tbody attributes =
    Html.tbody (List.map (Html.Attributes.map Basics.never) attributes)


{-| `thead` should generally not have event listeners.
-}
thead : List (Html.Attribute Never) -> List (Html msg) -> Html msg
thead attributes =
    Html.thead (List.map (Html.Attributes.map Basics.never) attributes)


{-| `tfoot` should generally not have event listeners.
-}
tfoot : List (Html.Attribute Never) -> List (Html msg) -> Html msg
tfoot attributes =
    Html.tfoot (List.map (Html.Attributes.map Basics.never) attributes)


{-| `tr` should generally not have event listeners.
-}
tr : List (Html.Attribute Never) -> List (Html msg) -> Html msg
tr attributes =
    Html.tr (List.map (Html.Attributes.map Basics.never) attributes)


{-| `td` should generally not have event listeners.
-}
td : List (Html.Attribute Never) -> List (Html msg) -> Html msg
td attributes =
    Html.td (List.map (Html.Attributes.map Basics.never) attributes)


{-| `th` should generally not have event listeners.
-}
th : List (Html.Attribute Never) -> List (Html msg) -> Html msg
th attributes =
    Html.th (List.map (Html.Attributes.map Basics.never) attributes)


{-| `form` should generally not have event listeners.
-}
form : List (Html.Attribute Never) -> List (Html msg) -> Html msg
form attributes =
    Html.form (List.map (Html.Attributes.map Basics.never) attributes)


{-| `fieldset` should generally not have event listeners.
-}
fieldset : List (Html.Attribute Never) -> List (Html msg) -> Html msg
fieldset attributes =
    Html.fieldset (List.map (Html.Attributes.map Basics.never) attributes)


{-| `legend` should generally not have event listeners.
-}
legend : List (Html.Attribute Never) -> List (Html msg) -> Html msg
legend attributes =
    Html.legend (List.map (Html.Attributes.map Basics.never) attributes)


{-| `label` should generally not have event listeners.
-}
label : List (Html.Attribute Never) -> List (Html msg) -> Html msg
label attributes =
    Html.label (List.map (Html.Attributes.map Basics.never) attributes)


{-| `datalist` should generally not have event listeners.
-}
datalist : List (Html.Attribute Never) -> List (Html msg) -> Html msg
datalist attributes =
    Html.datalist (List.map (Html.Attributes.map Basics.never) attributes)


{-| `optgroup` should generally not have event listeners.
-}
optgroup : List (Html.Attribute Never) -> List (Html msg) -> Html msg
optgroup attributes =
    Html.optgroup (List.map (Html.Attributes.map Basics.never) attributes)


{-| -}
option : List (Html.Attribute msg) -> List (Html msg) -> Html msg
option =
    Html.option


{-| `textarea` should generally not have event listeners.
-}
textarea : List (Html.Attribute Never) -> List (Html msg) -> Html msg
textarea attributes =
    Html.textarea (List.map (Html.Attributes.map Basics.never) attributes)


{-| `keygen` should generally not have event listeners.
-}
keygen : List (Html.Attribute Never) -> List (Html msg) -> Html msg
keygen attributes =
    Html.keygen (List.map (Html.Attributes.map Basics.never) attributes)


{-| `output` should generally not have event listeners.
-}
output : List (Html.Attribute Never) -> List (Html msg) -> Html msg
output attributes =
    Html.output (List.map (Html.Attributes.map Basics.never) attributes)


{-| `progress` should generally not have event listeners.
-}
progress : List (Html.Attribute Never) -> List (Html msg) -> Html msg
progress attributes =
    Html.progress (List.map (Html.Attributes.map Basics.never) attributes)


{-| `meter` should generally not have event listeners.
-}
meter : List (Html.Attribute Never) -> List (Html msg) -> Html msg
meter attributes =
    Html.meter (List.map (Html.Attributes.map Basics.never) attributes)


{-| `details` should generally not have event listeners.
-}
details : List (Html.Attribute Never) -> List (Html msg) -> Html msg
details attributes =
    Html.details (List.map (Html.Attributes.map Basics.never) attributes)


{-| `summary` should generally not have event listeners.
-}
summary : List (Html.Attribute Never) -> List (Html msg) -> Html msg
summary attributes =
    Html.summary (List.map (Html.Attributes.map Basics.never) attributes)


{-| `menuitem` should generally not have event listeners.
-}
menuitem : List (Html.Attribute Never) -> List (Html msg) -> Html msg
menuitem attributes =
    Html.menuitem (List.map (Html.Attributes.map Basics.never) attributes)


{-| `menu` should generally not have event listeners.
-}
menu : List (Html.Attribute Never) -> List (Html msg) -> Html msg
menu attributes =
    Html.menu (List.map (Html.Attributes.map Basics.never) attributes)