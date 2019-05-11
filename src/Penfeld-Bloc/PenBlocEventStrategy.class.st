Class {
	#name : #PenBlocEventStrategy,
	#superclass : #PenEventStrategy,
	#category : #'Penfeld-Bloc-Utils'
}

{ #category : #installing }
PenBlocEventStrategy >> bindAction: anEventBinding [
	anEventBinding source engineElement 
		when: BlClickEvent 
		do: [ :e | anEventBinding executeCallback ].
	^ true
]

{ #category : #installing }
PenBlocEventStrategy >> bindClick: anEventBinding [
	anEventBinding source engineElement 
		when: BlClickEvent 
		do: [ :e | anEventBinding executeCallback: (PenMouseEvent fromBloc: e) ].
	^ true
]

{ #category : #installing }
PenBlocEventStrategy >> bindMouseDown: anEventBinding [
	anEventBinding source engineElement 
		when: BlMouseDownEvent 
		do: [ :e | anEventBinding executeCallback: (PenMouseEvent fromBloc: e) ].
	^ true
]
