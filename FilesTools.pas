///Develop by Sergeev Andrey, Gavrilov Matvey, Yaurov Gleb
///NSTU IST I-02, 2022
///Разработано Сергеевым Андреем, Гавриловым Матвеем, Яуровым Глебом
///НГТУ ИСТ И-02, 2022
///
///Transfer and assignment of rights to other persons is PROHIBITED!
///Передача и присвоение прав другим лицам - ЗАПРЕЩЕНА!

unit FilesTools;

interface
///clearing the file along the way / очистка файла по пути
procedure ResetFile(path: string);
/// print to console and to file / печать и в консоль и в файл
procedure Print(path, s: string);
/// print to console and to file / печать и в консоль и в файл
procedure Println(path, s: string);

implementation

procedure ResetFile(path: string);
var
  tf: TextFile;
begin
  assign(tf, path);
  rewrite(tf);
  close(tf);
end;

procedure Print(path, s: string);
var
  tf: TextFile;
begin
  assign(tf, path);
  append(tf);
  write(s);
  write(tf, s);
  close(tf);
end;

procedure Println(path, s: string);
var
  tf: TextFile;
begin
  assign(tf, path);
  append(tf);
  writeln(s);
  writeln(tf, s);
  close(tf);
end;
end.