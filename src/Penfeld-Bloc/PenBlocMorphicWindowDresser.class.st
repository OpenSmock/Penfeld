Class {
	#name : #PenBlocMorphicWindowDresser,
	#superclass : #PenBlocDresser,
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocMorphicWindowDresser >> backgroundColor: aValue [
	self model engineElement root background: aValue.
]

{ #category : #dressing }
PenBlocMorphicWindowDresser >> initEngineElement [
	| element |
	element := self model docks first view displayComponent.

	self model engineElement: (BlSpace new
		extent: self model width pref @ self model height pref;
		title: self model title;
		yourself).
		
	self model engineElement root addChild: element engineElement.
	self model engineElement show
		
	
]
