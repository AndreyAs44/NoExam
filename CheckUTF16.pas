///Develop by Sergeev Andrey, Gavrilov Matvey, Yaurov Gleb
///NSTU IST I-02, 2022
///Разработано Сергеевым Андреем, Гавриловым Матвеем, Яуровым Глебом
///НГТУ ИСТ И-02, 2022
///
///Transfer and assignment of rights to other persons is PROHIBITED!
///Передача и присвоение прав другим лицам - ЗАПРЕЩЕНА!

unit CheckUTF16;

interface

///checking it UTF16LE / проверка совпадает ли с UTF16LE
function IsUTF16LE(const arr: array of integer): boolean;
///checking it UTF16BE / проверка совпадает ли с UTF16BE
function IsUTF16BE(const arr: array of integer): boolean;

implementation

function IsUTF16LE(const arr: array of integer): boolean;
var
  i: integer;
begin
  if (length(arr) > 3) then
  begin
    if ((arr[1] = 255) and (arr[2] = 254)) then
    begin
      i := 0;
      while (i < length(arr)) do 
      begin
        inc(i);
        if ((arr[i] = 0) or (arr[i] = 4)) then 
        begin
          IsUTF16LE := true;
          exit;
        end;
      end;
    end;
  end;
  
  IsUTF16LE := false;
end;

function IsUTF16BE(const arr: array of integer): boolean;
var
  i: integer;
begin
  if (length(arr) > 3) then
  begin
    if ((arr[1] = 254) and (arr[2] = 255)) then
    begin
      i := 0;
      while (i < length(arr) - 1) do 
      begin
        inc(i);
        if ((arr[i] = 0) or (arr[i] = 4)) then 
        begin
          IsUTF16BE := true;
          exit;
        end;
      end;
    end;
  end;
  
  IsUTF16BE := false;
end;
end.