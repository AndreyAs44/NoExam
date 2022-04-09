///Develop by Sergeev Andrey, Gavrilov Matvey, Yaurov Gleb
///NSTU IST I-02, 2022
///Разработано Сергеевым Андреем, Гавриловым Матвеем, Яуровым Глебом
///НГТУ ИСТ И-02, 2022
///
///Transfer and assignment of rights to other persons is PROHIBITED!
///Передача и присвоение прав другим лицам - ЗАПРЕЩЕНА!

unit FilesTools;

interface

uses Windows, SysUtils;

///clearing the file along the way / очистка файла по пути
procedure ResetFile(path: rawbytestring);
/// print to console and to file / печать и в консоль и в файл
procedure Print(path, s: rawbytestring);
/// print to console and to file / печать и в консоль и в файл
procedure Println(path, s: rawbytestring);

implementation

procedure ResetFile(path: rawbytestring);
var
  tf: TextFile;
begin
  path := ExtractFilePath(ParamStr(0)) + path;
  
  assign(tf, path);
  rewrite(tf);
  close(tf);
end;

procedure Print(path, s: rawbytestring);
var
  tf: TextFile;
begin
  path := ExtractFilePath(ParamStr(0)) + path;
  
  assign(tf, path);
  append(tf);
  write(s);
  write(tf, s);
  close(tf);
end;

procedure Println(path, s: rawbytestring);
var
  tf: TextFile;
begin
  path := ExtractFilePath(ParamStr(0)) + path;
  
  assign(tf, path);
  append(tf);
  writeln(s);
  writeln(tf, s);
  close(tf);
end;
end.