Class {
	#name : #PenBlocEngine,
	#superclass : #PenEngine,
	#category : #'Penfeld-Bloc-Utils'
}

{ #category : #accessing }
PenBlocEngine >> dressersMap [
	^ PenBlocDressersMap get
]

{ #category : #accessing }
PenBlocEngine >> eventStrategy [
	^ PenBlocEventStrategy
]

{ #category : #accessing }
PenBlocEngine >> name [
	^ 'Bloc'
]
