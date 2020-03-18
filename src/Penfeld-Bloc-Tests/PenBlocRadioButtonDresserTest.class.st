Class {
	#name : #PenBlocRadioButtonDresserTest,
	#superclass : #TestCase,
	#category : #'Penfeld-Bloc-Tests-Dressers'
}

{ #category : #running }
PenBlocRadioButtonDresserTest >> setUp [ 
	"Refresh style"
	PenDefaultStylesheet current
]

{ #category : #tests }
PenBlocRadioButtonDresserTest >> testBuild [
	<PenExample>
	| cmp element |
	cmp := PenRadioButton new
		dresser: PenBlocRadioButtonDresser new;
		text: 'Hello world';
		build.
	element := cmp engineElement.
	element forceLayout.
	
	^ element
]

{ #category : #tests }
PenBlocRadioButtonDresserTest >> testBuildChecked [
	<PenExample>
	| cmp element |
	cmp := PenRadioButton new
		dresser: PenBlocRadioButtonDresser new;
		check;
		text: 'Hello world';
		build.
	element := cmp engineElement.
	element forceLayout.
	
	^ element
]
