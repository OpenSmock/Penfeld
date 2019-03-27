Class {
	#name : #PenBlocBasicExamples,
	#superclass : #Object,
	#category : #'Penfeld-Bloc-Examples'
}

{ #category : #examples }
PenBlocBasicExamples class >> example10ComboBox [
	| model |
	model := PenGroupOld new vertical.
	10 timesRepeat: [ 
		model add: (
			PenComboBox new 
				addAllItems: (PenComponent withAllSubclasses collect: [ :c | PenLabel new 
					name: c name; 
					dresser: PenBlocLabel new ]);
				sortingBlock: [ :a :b | a text < b text ];
				yourself)].
	model build.
	self 
		openInWindow: model engineElement  
		named: self name
		extent: 300@300
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleButton [
	| model |
	model := (PenButton key: #myButton) 
		text: 'Button';
		position: 20@20;
		onActionDo: [ self inform: 'Do Action!' ].
	model dresser: PenBlocButtonDresser new.
	model openInInternalWindow 
	
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
	model openInInternalWindow
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
	model openInInternalWindow
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleComboBox [
	| model |
	model := PenComboBox new addAllItems: 
		(Object withAllSubclasses collect: [ :c | PenLabel text: c name]) .
	model onSelectionChangedDo: [ self inform: model selection printString ].
	model sortingBlock: [ :a :b | a text < b text ].
	model dresser: PenBlocComboBoxDresser new.
	model openInInternalWindow.
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
	component openInInternalWindow 
	
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleLabel [
	| model window |
	model := PenLabel text: 'A Simple Label'.
	model dresser: PenBlocLabelDresser new.
	
	window := PenWindow withDisplayComponent: model.
	window openInInternalWindow
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleLabel2 [
	| model |
	model := PenLabel new 
		text: 'Relocated Label';
		position: 100@100;
		yourself.
	model dresser: PenBlocLabelDresser new.
	
	model openInInternalWindow
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleLoadingButton [
	| component |
	component := PenButton new
		text: 'Button';
		position: 20@20.
	component onActionDo: [
		[ component loading: true.
		2 seconds wait.
		component loading: false.
		self inform: 'Do Action!' ] fork 
	].
	component dresser: PenBlocButtonDresser new.
	component openInInternalWindow 
	
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleProgressBar [
	| progressBar |
	progressBar := PenProgressBar new interval: (1 to: 10 by: 0.01).
	progressBar position: 20@20.
	progressBar dresser: PenBlocProgressBarDresser new.
	progressBar openInInternalWindow.
		
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
	
	container openInInternalWindow.
		
	[[progressBar isMax] whileFalse: [ progressBar increment. (Duration milliSeconds: 10) wait ]] fork.
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleRadioButton [
	| button |
	button := PenRadioButton new 
		text: 'Radio Button';
		labelAfter.
	button dresser: PenBlocRadioButtonDresser new. 
	button openInInternalWindow
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleRadioGroupLabelAfter [
	| group |
	group := PenRadioGroup new addAll: 
		((1 to: 5) collect: [ :i |
			PenRadioButton new 
				text: 'Radio Button ', i printString;
				labelAfter. ] ).
	group dresser: PenBlocRadioGroupDresser new.
	group openInInternalWindow
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleRadioGroupLabelBefore [
	| group |
	group := PenRadioGroup new addAll: 
		((1 to: 5) collect: [ :i |
			PenRadioButton new 
				text: 'Radio Button ', i printString;
				labelBefore. ] ).
	group dresser: PenBlocRadioGroupDresser new.
	group openInInternalWindow
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
	
	container openInInternalWindow
	
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
	
	container openInInternalWindow
	
]

{ #category : #examples }
PenBlocBasicExamples class >> exampleToggleButton [
	| component |
	component := PenToggleButton new
		text: 'Toggle';
		position: 20@20;
		onCheckedDo: [ self inform: 'Checked!' ];
		onUncheckedDo: [ self inform: 'Unchecked!' ].
	component dresser: PenBlocButtonDresser new.
	component openInInternalWindow 
	
]

{ #category : #examples }
PenBlocBasicExamples class >> textInPercent: aSlider [
	^ (aSlider fraction * 100) rounded printString, ' pourcents'
	
]

{ #category : #'see class side' }
PenBlocBasicExamples >> seeClassSide [
]
