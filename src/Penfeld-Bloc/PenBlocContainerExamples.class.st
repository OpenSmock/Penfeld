Class {
	#name : #PenBlocContainerExamples,
	#superclass : #Object,
	#classVars : [
		'mainContainer',
		'shape1',
		'shape2',
		'shape3',
		'visibleShape'
	],
	#category : #'Penfeld-Bloc-Examples'
}

{ #category : #examples }
PenBlocContainerExamples class >> example1 [
	| container label button window |
	label := PenLabel new 
		text: (String loremIpsum: 30);
		position: 40@40;
		yourself.
	
	button := PenButton new
		text: 'Click !';
		onActionDo: [ self inform: 'Clicked !' ];
		position: 40@80;
		yourself.
		
	container := PenContainer new 
		addElement: label;
		addElement: button;
		yourself.
	
	window := PenWindow withDisplayComponent: container.
	window title: self className.
	window open
]

{ #category : #examples }
PenBlocContainerExamples class >> example2 [
	| container label |
	label := PenLabel new 
		text: (String loremIpsum: 30).
		
	container := PenContainer new 
		addElement: label.
	
	container open
]

{ #category : #examples }
PenBlocContainerExamples class >> example3 [
	| radiosContainer radios |
	mainContainer := nil.
	visibleShape := nil.
	
	shape1 := PenShape new 
		key: #shape1;
		dresser: PenBlocShapeExperimentalDresser new;
		shape: (BlRectangle new extent: 100@100).
	shape2 := PenShape new 
		key: #shape2;
		dresser: PenBlocShapeExperimentalDresser new;
		shape: (BlRectangle new extent: 200@200).
	shape3 := PenShape new 
		key: #shape3;
		dresser: PenBlocShapeExperimentalDresser new;
		shape: (BlRectangle new extent: 300@300).
	radios := { 
		PenRadioButton new
			key: #radio1;
			text: 'Shape 1';
			check;
			onCheckedDo: [ self showShape: shape1 ].
		PenRadioButton new
			key: #radio2;
			text: 'Shape 2';
			onCheckedDo: [ self showShape: shape2 ].
		PenRadioButton new
			key: #radio3;
			text: 'Shape 3';
			onCheckedDo: [ self showShape: shape3 ].
	}.
	
	radiosContainer := PenContainer new
		key: #radios;
		layout: PenLinearLayout vertical;
		addAllElements: radios.
		
	PenRadioGroup new addAll: radios.
		
	visibleShape := shape1.
	mainContainer := PenContainer new 
		key: #main;
		layout: PenLinearLayout horizontal;
		addAllElements: { radiosContainer. visibleShape }.
		
	mainContainer open.
]

{ #category : #examples }
PenBlocContainerExamples class >> exampleShape [
	PenShape new 
		dresser: PenBlocShapeExperimentalDresser new;
		shape: (BlRectangle new extent: 100@100);
		openInWorld 
]

{ #category : #testing }
PenBlocContainerExamples class >> isDeprecated [ 
	^ true
]

{ #category : #examples }
PenBlocContainerExamples class >> showShape: aShape [
	mainContainer ifNil: [ ^ self ].
	aShape = visibleShape ifTrue: [ ^ self ].
	mainContainer removeElement: visibleShape.
	visibleShape := aShape.
	mainContainer addElement: visibleShape.
	
]

{ #category : #'see class side' }
PenBlocContainerExamples >> seeClassSide [ 
]
