Class {
	#name : #PenBlocEngine,
	#superclass : #PenEngine,
	#category : #'Penfeld-Bloc-Utils'
}

{ #category : #accessing }
PenBlocEngine >> dressersMap [
	^ PenBlocDressersMap new
]

{ #category : #accessing }
PenBlocEngine >> eventStrategy [
	^ PenBlocEventStrategy new
]

{ #category : #'as yet unclassified' }
PenBlocEngine >> name [
	^ 'Bloc'
]
