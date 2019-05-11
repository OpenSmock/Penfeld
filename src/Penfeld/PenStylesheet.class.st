Class {
	#name : #PenStylesheet,
	#superclass : #Object,
	#classVars : [
		'Current'
	],
	#category : #'Penfeld-Utils'
}

{ #category : #styles }
PenStylesheet class >> current [
	^ Current ifNil: [ Current := self light ].
	
]

{ #category : #styles }
PenStylesheet class >> dark [
	<script: 'self dark'>
	Current := PssParser parse: (self stylesheet: {
		#textColor -> '#E6E6E6'.
		#backgroundColor -> '#141414'.
		#borderColor -> '#C8C8C8'.
		#activeColor -> '#063845'.
		#checkedColor -> '#276443'.
		#disabledColor -> '#787878'.
		#buttonBackgroundColor -> '#323232'.
	} asDictionary).
	^ self current
]

{ #category : #styles }
PenStylesheet class >> light [
	<script: 'self light'>
	Current := PssParser parse: (self stylesheet: {
		#textColor -> '#1E1E1E'.
		#backgroundColor -> '#F0F0F0'.
		#borderColor -> '#505050'.
		#activeColor -> '#8BBABB'.
		#checkedColor -> '#52AF7E'.
		#disabledColor -> '#787878'.
		#buttonBackgroundColor -> '#D2D2D2'.
	} asDictionary).
	PenDisplayComponent allInstancesDo: [ :component | component refresh ].
	^ self current
]

{ #category : #css }
PenStylesheet class >> stylesheet: colors [
	^ '
* { 
	font-size: 16;
	color: ', (colors at: #textColor), ';
 }

*:active { 
	background-color: ', (colors at: #activeColor), ';
 }

*:checked { 
	background-color: ', (colors at: #checkedColor), ';
 }

*:unchecked { 
	background-color: ', (colors at: #backgroundColor), ';
 }

*:disabled { 
	background-color: ', (colors at: #disabledColor), ';
 }

button, toggle { 
	width: 150;
	height: 30;
	text-align: center;
	background-color: ', (colors at: #buttonBackgroundColor), ';
	border: 1px solid ', (colors at: #borderColor), ';
 }

.squareButton { 
	width: 30;
	height: 30;
 }

th { 
	background-color: ', (colors at: #buttonBackgroundColor), ';
 }

comboBox.cbbutton { 
	width: 30;
	height: 30;
	background-color: ', (colors at: #buttonBackgroundColor), ';
 }

'
]
