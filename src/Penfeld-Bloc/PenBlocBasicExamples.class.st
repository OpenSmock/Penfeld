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

{ #category : #'see class side' }
PenBlocBasicExamples >> seeClassSide [
]
