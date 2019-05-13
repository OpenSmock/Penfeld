Extension { #name : #PenMouseEvent }

{ #category : #'*Penfeld-Bloc' }
PenMouseEvent class >> fromBloc: aBlocEvent [
	^ self new
		point: aBlocEvent position;
		screenPoint: aBlocEvent screenPosition;
		yourself
]
