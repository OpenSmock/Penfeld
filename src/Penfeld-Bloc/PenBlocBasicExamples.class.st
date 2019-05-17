Class {
	#name : #PenBlocBasicExamples,
	#superclass : #Object,
	#category : #'Penfeld-Bloc-Examples'
}

{ #category : #examples }
PenBlocBasicExamples class >> example10ComboBox [
	| component |
	component := PenContainer new.
	component layout: PenLinearLayout vertical.
	10 timesRepeat: [ 
		component addElement: (
			PenComboBox new 
				addAllItems: (PenComponent withAllSubclasses 
					collect: [ :c | PenLabel new text: c name ]);
				sortingBlock: [ :a :b | a text < b text ]
		)
	].
	component build.
	component openInWorld.
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleButton [
	| component |
	component := (PenButton key: #myButton) 
		text: 'Button';
		onActionDo: [ self inform: 'Do Action!' ].
	component dresser: PenBlocButtonDresser new.
	component openInWorld 
	
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleCheckBoxLabelAfter [
	| model |
	model := PenCheckBox new 
		text: 'a CheckBox';
		labelAfter;
		yourself.
	model onCheckedDo: [ self inform: 'Checked !' ].
	model onUncheckedDo: [ self inform: 'Unchecked !' ].
	model onValueChangedDo: [ self inform: 'ValueChanged !' ].
	model dresser: PenBlocCheckBoxDresser new.
	model openInWorld
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleCheckBoxLabelBefore [
	| model |
	model := PenCheckBox new 
		text: 'a CheckBox';
		labelBefore;
		yourself.
	model onCheckedDo: [ self inform: 'Checked !' ].
	model onUncheckedDo: [ self inform: 'Unchecked !' ].
	model onValueChangedDo: [ self inform: 'ValueChanged !' ].
	model dresser: PenBlocCheckBoxDresser new.
	model openInWorld
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleComboBox [
	| model |
	model := PenComboBox new addAllItems: 
		(Object withAllSubclasses collect: [ :c | PenLabel text: c name]) .
	model onSelectionChangedDo: [ self inform: model selection printString ].
	model sortingBlock: [ :a :b | a text < b text ].
	model dresser: PenBlocComboBoxDresser new.
	model openInWorld.
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleComboBoxOverflow [
	| component window |
	
	component := PenComboBox new addAllItems: 
		(Object withAllSubclasses collect: [ :c | PenLabel text: c name]) .
	component onSelectionChangedDo: [ self inform: component selection printString ].
	component sortingBlock: [ :a :b | a text < b text ].
	component dresser: PenBlocComboBoxDresser new.
	
	window := PenWindow withDisplayComponent: component.
	window size: 300@40.
	window open
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleDisabledButton [
	| component |
	component := PenButton new
		text: 'Button';
		disable;
		position: 20@20;
		onActionDo: [ self inform: 'Do Action!' ].
	component dresser: PenBlocButtonDresser new.
	component openInWorld 
	
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleLabel [
	| model window |
	model := PenLabel text: 'A Simple Label'.
	model dresser: PenBlocLabelDresser new.
	
	window := PenWindow withDisplayComponent: model.
	window openInWorld
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleLabel2 [
	| model |
	model := PenLabel new 
		text: 'Relocated Label';
		position: 100@100;
		yourself.
	model dresser: PenBlocLabelDresser new.
	
	model openInWorld
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleLoadingButton [
	| component |
	component := PenButton new
		text: 'Button';
		position: 20@20.
	component onActionDo: [
		[ component disable.
		component activatePseudoClass: #loading.
		2 seconds wait.
		component deactivatePseudoClass: #loading.
		component enable.
		self inform: 'Do Action!' ] fork 
	].
	component dresser: PenBlocButtonDresser new.
	component openInWorld 
	
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleProgressBar [
	| progressBar |
	progressBar := PenProgressBar new interval: (1 to: 10 by: 0.01).
	progressBar position: 20@20.
	progressBar dresser: PenBlocProgressBarDresser new.
	progressBar openInWorld.
		
	[[progressBar isMax] whileFalse: [ progressBar increment. (Duration milliSeconds: 10) wait ]] fork.
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleProgressBarWithPercentage [
	| progressBar label container |
	progressBar := PenProgressBar new interval: (1 to: 10 by: 0.01).
	progressBar position: 20@20.
	progressBar dresser: PenBlocProgressBarDresser new.
	
	label := PenLabel text: (self textInPercent: progressBar).
	label position: 20@50.

	container := PenContainer new.
	container size: 300 @ 300.
	container addAllElements: {progressBar. label}.
	
	progressBar onValueChangedDo: [ label text: (self textInPercent: progressBar) ].
	
	container openInWorld.
		
	[[progressBar isMax] whileFalse: [ progressBar increment. (Duration milliSeconds: 10) wait ]] fork.
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleRadioButton [
	| button |
	button := PenRadioButton new 
		text: 'Radio Button';
		labelAfter.
	button dresser: PenBlocRadioButtonDresser new. 
	button openInWorld
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleRadioGroupLabelAfter [
	| radios container group |
	radios := ((1 to: 5) collect: [ :i |
		PenRadioButton new 
			key: ('radio', i printString) asSymbol;
			text: 'Radio Button ', i printString;
			labelAfter. ] ).
	group := PenRadioGroup new addAll: radios.
	container := PenContainer new 
		layout: PenLinearLayout vertical;
		addAllElements: radios.
	container openInWorld
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleRadioGroupLabelBefore [
	| radios container group |
	radios := ((1 to: 5) collect: [ :i |
		PenRadioButton new 
			key: ('radio', i printString) asSymbol;
			text: 'Radio Button ', i printString;
			labelBefore. ] ).
	group := PenRadioGroup new addAll: radios.
	container := PenContainer new 
		layout: PenLinearLayout vertical;
		addAllElements: radios.
	container openInWorld
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleSlider [
	| container slider label |
	slider := PenSlider new interval: (1 to: 10 by: 0.01).
	slider middle.
	slider position: 20@20.
	slider dresser: PenBlocSliderDresser new.
	
	label := PenLabel text: (slider value round: 1) printString.
	label position: 20@50.

	container := PenContainer new.
	container size: 300 @ 300.
	container addAllElements: {slider. label}.
	
	slider onValueChangedDo: [ label text: (slider value round: 1) printString ].
	
	container openInWorld
	
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleSlider2 [
	| container slider label |
	slider := PenSlider new interval: (1 to: 10).
	slider middle.
	slider position: 20@20.
	slider dresser: PenBlocSliderDresser new.
	
	label := PenLabel text: (slider value round: 1) printString.
	label position: 20@50.

	container := PenContainer new.
	container size: 300 @ 300.
	container addAllElements: {slider. label}.
	
	slider onValueChangedDo: [ label text: (slider value round: 1) printString ].
	
	container openInWorld
	
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleToggleButton [
	| component |
	component := PenToggleButton new
		text: 'Toggle';
		position: 20@20;
		onCheckedDo: [ self inform: 'Checked!' ];
		onUncheckedDo: [ self inform: 'Unchecked!' ];
		onActionDo: [ self inform: 'Action' ].
	component dresser: PenBlocButtonDresser new.
	component openInWorld 
	
]

{ #category : #examples }
PenBlocBasicExamples class >> textInPercent: aSlider [
	^ (aSlider fraction * 100) rounded printString, ' pourcents'
	
]

{ #category : #'see class side' }
PenBlocBasicExamples >> seeClassSide [
]
