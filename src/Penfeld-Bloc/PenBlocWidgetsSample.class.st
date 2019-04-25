Class {
	#name : #PenBlocWidgetsSample,
	#superclass : #PenStylesheet,
	#category : #'Penfeld-Bloc-Examples'
}

{ #category : #'instance creation' }
PenBlocWidgetsSample class >> open [
	<script: 'self open'>
	^ self new open
]

{ #category : #accessing }
PenBlocWidgetsSample >> button [
	^ PenButton new
		text: 'Button';
		size: 90 @ 40
]

{ #category : #accessing }
PenBlocWidgetsSample >> checkBoxs [
	^ PenContainer new
		layout: PenLinearLayout vertical;
		addAllElements: { 
			PenCheckBox new text: 'Value A'.
			PenCheckBox new text: 'Value B'.
			PenCheckBox new text: 'Value C'.
		 }
]

{ #category : #accessing }
PenBlocWidgetsSample >> disableButton [
	^ PenButton new
		text: 'Button';
		disable;
		size: 90 @ 40
]

{ #category : #accessing }
PenBlocWidgetsSample >> iconButton [
	^ PenButton new
		text: 'Challenge';
		size: 150 @ 75
]

{ #category : #accessing }
PenBlocWidgetsSample >> open [
	| container |
	container := PenContainer new
		key: #mainContainer;
		size: 800@600.
	container addAllElements: { 
		self button position: 10@10.
		self toggleButton position: 110@10.
		self disableButton position: 10@60.
		self toggleDisabledButton position: 110@60.
		self iconButton position: 210@10.
		self checkBoxs position: 370@10.
		self radios position: 10@120.
		self slider position: 10@180.
		self slider2 position: 10@240.
		self progressBar position: 10@300.
	}.
	container openInWorld
]

{ #category : #accessing }
PenBlocWidgetsSample >> progressBar [
	^ PenProgressBar new
		interval: (0 to: 100 by: 1);
		size: 300@20
]

{ #category : #accessing }
PenBlocWidgetsSample >> radioButton: aLabel [
	^ PenRadioButton new 
		addStyleClass: #button;
		label: aLabel; 
		size: 90@50
			
]

{ #category : #accessing }
PenBlocWidgetsSample >> radios [
	^ PenRadioGroup new addAll:
		{ 
			self radioButton: '0 m2'. 
			self radioButton: '5 m2'. 
			self radioButton: '50 m2'. 
		}
]

{ #category : #accessing }
PenBlocWidgetsSample >> slider [
	^ PenSlider new
		interval: (0 to: 350 by: 10);
		middle
]

{ #category : #accessing }
PenBlocWidgetsSample >> slider2 [
	^ PenSlider new
		interval: (40 to: 180 by: 20);
		middle
]

{ #category : #accessing }
PenBlocWidgetsSample >> toggleButton [
	^ PenToggleButton new
		text: 'Toggle';
		size: 90 @ 40
]

{ #category : #accessing }
PenBlocWidgetsSample >> toggleDisabledButton [
	^ PenToggleButton new
		check;
		disable;
		text: 'Toggle';
		size: 90 @ 40
]
