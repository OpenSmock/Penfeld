Class {
	#name : #PenStylesheet,
	#superclass : #Object,
	#classVars : [
		'Current'
	],
	#category : #'Penfeld-Core'
}

{ #category : #styles }
PenStylesheet class >> current [
	^ Current ifNil: [ Current := self light ].
	
]

{ #category : #styles }
PenStylesheet class >> dark [
	<script: 'self dark'>
	Current := StyleParser parse: (self stylesheet: {
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
	Current := StyleParser parse: (self stylesheet: {
		#textColor -> '#1E1E1E'.
		#backgroundColor -> '#FFFFFF'.
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
	background-color: ', (colors at: #backgroundColor), ';
	border: 1px solid ', (colors at: #borderColor), ';
	font-size: 16;
	text-align: center;
	color: ', (colors at: #textColor), ';
 }

label { 
	background-color: transparent;
 }

*:active { 
	background-color: ', (colors at: #activeColor), ';
 }

*:checked { 
	background-color: ', (colors at: #checkedColor), ';
 }

*:disabled { 
	background-color: ', (colors at: #disabledColor), ';
 }

button, toggle { 
	width: 150;
	height: 30;
	background-color: ', (colors at: #buttonBackgroundColor), ';
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
