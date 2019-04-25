Class {
	#name : #PenBlocMorphicWindowDresser,
	#superclass : #PenBlocDresser,
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocMorphicWindowDresser >> backgroundColor: aValue [
	self component engineElement root background: aValue.
]

{ #category : #dressing }
PenBlocMorphicWindowDresser >> initEngineElement [
	| element |
	element := self component docks first view displayComponent.

	self component engineElement: (BlSpace new
		extent: self component width pref @ self component height pref;
		title: self component title;
		yourself).
		
	self component engineElement root addChild: element engineElement.
	self component engineElement show
		
	
]
