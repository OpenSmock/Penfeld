Class {
	#name : #PenStylesheet,
	#superclass : #Object,
	#classVars : [
		'Current'
	],
	#category : #'Penfeld-Utils'
}

{ #category : #cleanup }
PenStylesheet class >> cleanUp [ 
	Current := nil
]

{ #category : #private }
PenStylesheet class >> createStylesheet: colors [
	^ '
* { 
	font-size: 14;
	color: ', (colors at: #textColor), ';
 }

label.title { 
	font-size: 16;
	font-style: italic;
	margin: 15px 10px 5px;
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
	width: 100;
	height: 30;
	text-align: center;
	margin: 5px 10px;
	background-color: ', (colors at: #buttonBackgroundColor), ';
	border: 1px solid ', (colors at: #borderColor), ';
 }

radioButton, checkButton { 
	margin: 0 10px;
 }

th { 
	background-color: ', (colors at: #buttonBackgroundColor), ';
 }

comboBox { 
	margin: 5px;
}

comboBox.cbbutton { 
	width: 30;
	height: 30;
	background-color: ', (colors at: #buttonBackgroundColor), ';
 }

'
]

{ #category : #accesing }
PenStylesheet class >> current [
	Current ifNil: [ Current := #lightStyle ].
	^ self perform: Current.
	
]

{ #category : #styles }
PenStylesheet class >> dark [
	<script: 'self dark'>
	Current := #darkStyle.
	^ self current 
]

{ #category : #private }
PenStylesheet class >> darkStyle [
	^ PssParser parse: (self createStylesheet: {
		#textColor -> '#E6E6E6'.
		#backgroundColor -> '#141414'.
		#borderColor -> '#C8C8C8'.
		#activeColor -> '#063845'.
		#checkedColor -> '#276443'.
		#disabledColor -> '#787878'.
		#buttonBackgroundColor -> '#323232'.
	} asDictionary).
]

{ #category : #styles }
PenStylesheet class >> light [
	<script: 'self light'>
	Current := #lightStyle.
	^ self current 
]

{ #category : #private }
PenStylesheet class >> lightStyle [
	^ PssParser parse: (self createStylesheet: {
		#textColor -> '#1E1E1E'.
		#backgroundColor -> '#F0F0F0'.
		#borderColor -> '#505050'.
		#activeColor -> '#8BBABB'.
		#checkedColor -> '#52AF7E'.
		#disabledColor -> '#787878'.
		#buttonBackgroundColor -> '#D2D2D2'.
	} asDictionary).
]
