Class {
	#name : #PenBlocListDresserTest,
	#superclass : #TestCase,
	#category : #'Penfeld-Bloc-Tests-Dressers'
}

{ #category : #running }
PenBlocListDresserTest >> setUp [ 
	"Refresh style"
	PenDefaultStylesheet current
]

{ #category : #tests }
PenBlocListDresserTest >> testBuild [
	<PenExample>
	| cmp element |
	cmp := PenList new 
		addAllItems: 
			(PenComponent withAllSubclasses collect: [ :c | PenLabel new 
				text: c name; 
				yourself ]);
		dresser: PenBlocListDresser new;
		build.
	element := cmp engineElement.
	element forceLayout.
	
	^ element
]
