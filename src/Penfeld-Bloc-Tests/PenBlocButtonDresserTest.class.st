"
A PenBlocButtonDresserTest is a test class for testing the behavior of PenBlocButtonDresser
"
Class {
	#name : #PenBlocButtonDresserTest,
	#superclass : #TestCase,
	#category : #'Penfeld-Bloc-Tests-Dressers'
}

{ #category : #running }
PenBlocButtonDresserTest >> setUp [ 
	"Refresh style"
	PenDefaultStylesheet current
]

{ #category : #test }
PenBlocButtonDresserTest >> testBackgroundOn [
	| button element background |
	button := PenButton new
		dresser: PenBlocButtonDresser new;
		build.
	element := button engineElement.
	element forceLayout.
	
	"Default PenStylesheet values"
	background := element background.
	self deny: background equals: element defaultBackground.
	
	button activatePseudoClass: #active.
	button forceRefresh.
	element forceLayout.
	self deny: element background equals: background.
	
	button deactivatePseudoClass: #active.
	button forceRefresh.
	element forceLayout.
	self assert: element background equals: background.
]

{ #category : #tests }
PenBlocButtonDresserTest >> testBuild [
	<PenExample>
	| button element |
	button := PenButton new
		dresser: PenBlocButtonDresser new;
		build.
	element := button engineElement.
	element forceLayout.
	
	"Default PenStylesheet values"
	self assert: element size equals: 100@30.
	
	^ element
]

{ #category : #tests }
PenBlocButtonDresserTest >> testBuildIcon [
	<PenExample>
	| button element |
	button := PenButton new
		icon: (self iconNamed: #add);
		dresser: PenBlocButtonDresser new;
		build.
	element := button engineElement.
	element forceLayout.
	
	"Default PenStylesheet values"
	self assert: element size equals: 100@30.
	
	^ element
]

{ #category : #tests }
PenBlocButtonDresserTest >> testBuildText [
	<PenExample>
	| button element |
	button := PenButton new
		text: 'Button';
		dresser: PenBlocButtonDresser new;
		build.
	element := button engineElement.
	element forceLayout.
	
	"Default PenStylesheet values"
	self assert: element size equals: 100@30.
	
	^ element
]

{ #category : #tests }
PenBlocButtonDresserTest >> testBuildTextIcon [
	<PenExample>
	| button element |
	button := PenButton new
		text: 'Button';
		icon: (self iconNamed: #add);
		dresser: PenBlocButtonDresser new;
		build.
	element := button engineElement.
	element forceLayout.
	
	"Default PenStylesheet values"
	self assert: element size equals: 100@30.
	
	^ element
]

{ #category : #test }
PenBlocButtonDresserTest >> testPositionOn [
	| button element |
	button := PenButton new
		position: 20@30;
		dresser: PenBlocButtonDresser new;
		build.
	element := button engineElement.
	element forceLayout.
	
	"Default PenStylesheet values"
	self assert: element position equals: 20@30.
]
