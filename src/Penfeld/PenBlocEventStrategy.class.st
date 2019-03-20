Class {
	#name : #PenBlocEventStrategy,
	#superclass : #PenEventStrategy,
	#category : #'Penfeld-Bloc-Utils'
}

{ #category : #installing }
PenBlocEventStrategy >> installActionOn: aModel [
	aModel interactor when: BlClickEvent do: 
		[ :e | aModel actionEvent ]
]

{ #category : #installing }
PenBlocEventStrategy >> installClickOn: aModel [
	aModel interactor when: BlMouseDownEvent do: 
		[ :e | | event |
		event := PFMouseEvent fromBloc: e.
		aModel clickEvent: event. ]
]

{ #category : #installing }
PenBlocEventStrategy >> installMouseDownOn: aModel [
	aModel interactor when: BlMouseDownEvent do: 
		[ :e | | event |
		event := PFMouseEvent fromBloc: e.
		aModel mouseDownEvent: event. ]
]
