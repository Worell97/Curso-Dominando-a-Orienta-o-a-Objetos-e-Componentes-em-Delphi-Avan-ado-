unit uObserver;

interface

uses Classes;

type
	TObservable = class;

	IObserver = interface
		procedure Update(ASubject: TObservable);
	end;

	/// <author>Oscar Worell</author>
	/// <Descricao>Esta classe é a classe basica de teste</Descricao>
	TObservable = class
	strict private
		FObservers: TList;
	public
		constructor Create;
		procedure Attach(AObserver: IObserver);
		procedure Detach(AObserver: IObserver);
	strict protected
		procedure NotifyObservers;
	end;

	TCotacao = class(TObservable)
	end;

	TProduto = class(TInterfacedObject, IObserver)
	public
		procedure Update(ASubject: TObservable);
	end;

implementation

constructor TObservable.Create;
begin
	inherited Create;
	FObservers := TList.Create;
end;

procedure TObservable.Attach(AObserver: IObserver);
begin
	FObservers.Add(@AObserver);
end;

procedure TObservable.Detach(AObserver: IObserver);
var
	idx: Integer;
begin
	idx := FObservers.IndexOf(@AObserver);
	If idx <> -1 Then
	begin
		FObservers.Delete(idx);
	end;
end;

procedure TObservable.NotifyObservers;
var
	Current: ^IObserver;
begin
	for Current in FObservers do
	begin
		Current.Update(self);
	end;
end;

procedure TProduto.Update(ASubject: TObservable);
begin
	// put your code here
end;

end.
