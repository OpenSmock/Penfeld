Class {
	#name : #PenBlocLabelDresserTest,
	#superclass : #TestCase,
	#category : #'Penfeld-Bloc-Tests-Dressers'
}

{ #category : #running }
PenBlocLabelDresserTest >> setUp [ 
	"Refresh style"
	PenDefaultStylesheet current
]

{ #category : #tests }
PenBlocLabelDresserTest >> testBuild [
	<PenExample>
	| label element |
	label := PenLabel new
		dresser: PenBlocLabelDresser new;
		text: 'Hello world';
		build.
	element := label engineElement.
	element forceLayout.
	
	^ element
]

{ #category : #tests }
PenBlocLabelDresserTest >> testPositionOn [
	| label element |
	label := PenLabel new
		dresser: PenBlocLabelDresser new;
		text: 'Hello world';
		position: 10@15;
		build.
	element := label engineElement.
	element forceLayout.
	
	self assert: element position equals: 10@15
]
