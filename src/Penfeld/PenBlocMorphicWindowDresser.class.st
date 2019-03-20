Class {
	#name : #PenBlocMorphicWindowDresser,
	#superclass : #PenBlocDresser,
	#category : #'Penfeld-Bloc-Dressers'
}

{ #category : #styling }
PenBlocMorphicWindowDresser >> backgroundColor: aValue [
	self model interactor root background: aValue.
]

{ #category : #dressing }
PenBlocMorphicWindowDresser >> initInteractor [
	| element |
	element := self model docks first view displayComponent.

	self model interactor: (BlSpace new
		extent: self model width pref @ self model height pref;
		title: self model title;
		yourself).
		
	self model interactor root addChild: element interactor.
	self model interactor show
		
	
]
