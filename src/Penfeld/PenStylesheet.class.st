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

{ #category : #styles }
PenStylesheet class >> colored [
	<script: 'self colored'>
	Current := #coloredStyle.
	^ self current 
]

{ #category : #private }
PenStylesheet class >> coloredStyle [
	^ self parse: (self createStylesheet2: {
		#lightTextColor -> '#CDE1E4'.
		#darkTextColor -> '#343A3B'.
		#backgroundColor -> '#9AA3A4'.
		#borderColor -> '#3B919E'.
		#activeColor -> '#9E3B63'.
		#checkedColor -> '#4EA5C5'.
		#disabledColor -> '#344A71'.
		#buttonBackgroundColor -> '#374D8D'.
		#buttonBackgroundColor2 -> '#4E6DC5'.
	} asDictionary).
]

{ #category : #private }
PenStylesheet class >> createStylesheet2: colors [
	^ '
* { 
	font-size: 16;
	color: ', (colors at: #darkTextColor), ';
 }

.root { 
	background-color: ', (colors at: #backgroundColor), ';
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
	background-color: ', (colors at: #buttonBackgroundColor), ';
 }

*:disabled { 
	background-color: ', (colors at: #disabledColor), ';
 }

button, toggle { 
	width: 100;
	height: 45;
	text-align: center;
	margin: 5px 10px;
	background-image: linear-gradient(
		', (colors at: #buttonBackgroundColor2), ' 0%,
		', (colors at: #buttonBackgroundColor), ' 100%
	);
	border: 4px solid ', (colors at: #borderColor), ';
	color: ', (colors at: #lightTextColor), ';
 }

button:unchecked, toggle:unchecked { 
	background-image: linear-gradient(
		', (colors at: #buttonBackgroundColor2), ' 0%,
		', (colors at: #buttonBackgroundColor), ' 100%
	);
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

{ #category : #private }
PenStylesheet class >> createStylesheet: colors [
	^ '
* { 
	font-size: 14;
	color: ', (colors at: #textColor), ';
 }

.root { 
	background-color: ', (colors at: #backgroundColor), ';
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

list, tree, table { 
	width: 300;
	margin: 20;
}

shape { 
	background-color: ', (colors at: #activeColor), ';
	border: 1px solid ', (colors at: #borderColor), ';
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
	^ self parse: (self createStylesheet: {
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
	^ self parse: (self createStylesheet: {
		#textColor -> '#1E1E1E'.
		#backgroundColor -> '#F0F0F0'.
		#borderColor -> '#505050'.
		#activeColor -> '#8BBABB'.
		#checkedColor -> '#52AF7E'.
		#disabledColor -> '#787878'.
		#buttonBackgroundColor -> '#D2D2D2'.
	} asDictionary).
]

{ #category : #parsing }
PenStylesheet class >> parse: aString [
	^ PssSimpleParser parse: aString
]
