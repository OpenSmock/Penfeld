Class {
	#name : #PenBlocContainerExamples,
	#superclass : #Object,
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
	
	container openInWorld 
]

{ #category : #'see class side' }
PenBlocContainerExamples >> seeClassSide [ 
]
