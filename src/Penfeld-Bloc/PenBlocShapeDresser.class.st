Class {
	#name : #PenBlocShapeDresser,
	#superclass : #PenBlocDresser,
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocShapeDresser >> font: aModel on: aComponent [
	"There is no text on shape"
]

{ #category : #dressing }
PenBlocShapeDresser >> initEngineElementFor: aComponent [
	| element |
	element := aComponent shape asBlElement.
	element
		border: BlBorder empty;
		background: BlBackground transparent.
	
	aComponent hasEvents ifFalse: [ element preventMeAndChildrenMouseEvents ].
	aComponent engineElement: element.
]

{ #category : #styling }
PenBlocShapeDresser >> text: aModel on: aComponent [
	"There is no text on shape"
]
