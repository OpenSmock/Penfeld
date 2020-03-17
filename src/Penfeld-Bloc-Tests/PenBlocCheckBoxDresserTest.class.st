Class {
	#name : #PenBlocCheckBoxDresserTest,
	#superclass : #TestCase,
	#category : #'Penfeld-Bloc-Tests-Dressers'
}

{ #category : #running }
PenBlocCheckBoxDresserTest >> setUp [ 
	"Refresh style"
	PenDefaultStylesheet current
]

{ #category : #tests }
PenBlocCheckBoxDresserTest >> testBuild [
	<PenExample>
	| cmp element |
	cmp := PenCheckBox new
		dresser: PenBlocCheckBoxDresser new;
		text: 'Hello world';
		build.
	element := cmp engineElement.
	element forceLayout.
	
	^ element
]
