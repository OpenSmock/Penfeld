Class {
	#name : #PenBlocEngine,
	#superclass : #PenEngine,
	#category : #'Penfeld-Bloc-Utils'
}

{ #category : #accessing }
PenBlocEngine >> dressersMap [
	^ PenBlocBasicDressersMap new
]

{ #category : #accessing }
PenBlocEngine >> eventStrategy [
	^ PenBlocEventStrategy new
]

{ #category : #accessing }
PenBlocEngine >> name [
	^ 'Bloc'
]
