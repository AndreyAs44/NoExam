///Develop by Sergeev Andrey, Gavrilov Matvey, Yaurov Gleb
///NSTU IST I-02, 2022
///Разработано Сергеевым Андреем, Гавриловым Матвеем, Яуровым Глебом
///НГТУ ИСТ И-02, 2022
///
///Transfer and assignment of rights to other persons is PROHIBITED!
///Передача и присвоение прав другим лицам - ЗАПРЕЩЕНА!

program GetBytesFromFile;

uses windows, sysutils, classes, FilesTools;

const
  ///folder with text files / папка с текстовыми файлами
  IN_PATH: rawbytestring  = '\In_Files\';
  
  ///console file / файл того что в консоли
  OUT_PATH: rawbytestring = '\Out_Files\LogByteCodes.txt';

var
  readStr: rawbytestring;
  massiv: Array of String;
  ind: integer;

///byte code of characters in the file, and print / байт код символов в файле, и печатает
procedure FileToBytePrint(name: rawbytestring);
var
  tf: TextFile;
  temp, s: rawbytestring;
  ws: widestring;
  i, m, n: integer;
  singleByteArr, doubleByteArr: array of integer;
begin
  Println(OUT_PATH, IN_PATH + name);
  assign(tf, ExtractFilePath(ParamStr(0)) + IN_PATH + name);
  
  //сканирование файла
  reset(tf);
  s := '';
  while not eof(tf) do
  begin
    readln(tf, temp);
    s := s + temp;
  end;
  close(tf);
  
  ///calculating a single byte array / вычисление одиночного байт массива
  i := 0;
  setLength(singleByteArr, 0);
  setLength(singleByteArr, length(s) + 1);
  while (i < length(s)) do
  begin
    inc(i);
    singleByteArr[i] := integer(ord(s[i]));
  end;
  
  ///calculating a double byte array / вычисление двойного байт массива
  m := length(s); 
  setlength(ws, m);
  n := MultiByteToWideChar(CP_UTF8, 0, pchar(s), m, pwidechar(ws), m);
  //
  i := 0;
  setLength(doubleByteArr, 0);
  setLength(doubleByteArr, length(ws) + 1);
  while (i < length(ws)) do
  begin
    inc(i);
    doubleByteArr[i] := integer(ord(ws[i]));
    
    if (integer(ord(ws[i])) = 0) then 
    begin
      setLength(doubleByteArr, i);
      break;
    end;
  end;
  
  Println(OUT_PATH, 'SingleByteArr: (' + intToStr(length(singleByteArr) - 1) + ')');
  i := 0;
  while (i < length(singleByteArr) - 1) do
  begin
    inc(i);
    if (i <> length(singleByteArr) - 1) then
      Print(OUT_PATH, intToStr(singleByteArr[i]) + ', ')
    else Print(OUT_PATH, intToStr(singleByteArr[i]));
  end;
  
  Println(OUT_PATH, ' ');
  Println(OUT_PATH, 'DoubleByteArr: (' + intToStr(length(doubleByteArr) - 1) + ')');
  i := 0;
  while (i < length(doubleByteArr) - 1) do
  begin
    inc(i);
    if (i <> length(doubleByteArr) - 1) then
      Print(OUT_PATH, intToStr(doubleByteArr[i]) + ' ')
    else Print(OUT_PATH, intToStr(doubleByteArr[i]));
  end;
  
  Println(OUT_PATH, ' ');
  Println(OUT_PATH, ' ');
end;

// поиск файлов
procedure FindFiles;
var
  SearchRec: TSearchRec; // информация о файле или каталоге
  FileName, cDir: String;
  n: LongInt;

begin
  n := 1;
  cDir := ExtractFilePath(ParamStr(0)) + IN_PATH; // Искать в папке с программой
  FileName := '*.txt'; // Ищем все файлы
  ChDir(cDir);// войти в каталог
  if FindFirst(FileName, faArchive, SearchRec) = 0 then
    repeat
      if (SearchRec.Attr and faAnyFile) = SearchRec.Attr then
      begin
        SetLength(massiv, Length(massiv) + 1);
        massiv[n - 1] := SearchRec.Name;
        inc(n);
      end;
    until (FindNext(SearchRec) <> 0)
end;

begin
  ResetFile(OUT_PATH);
  
  while (true) do 
  begin
    writeln('Scan all in path? (y/n)');
    readln(readStr);
    if (readStr = 'y') then 
    begin
      
      
      FindFiles();
      ind := 0;
      while (ind < length(massiv)) do
      begin
        FileToBytePrint(massiv[ind]);
        inc(ind);
      end;
      
      writeln('Enter "reset" to delete text in log.txt')
    end
    else if (readStr = 'n') then 
    begin
      writeln('Enter "name".txt');
      readln(readStr);
      
      if (not (FileExists(ExtractFilePath(ParamStr(0)) + IN_PATH + readStr))) then
      begin
        writeln('File ', ExtractFilePath(ParamStr(0)) + IN_PATH + readStr, ' not found.' + #10);
        continue;
      end;
      
      FileToBytePrint(readStr);
      
      writeln('Enter "reset" to delete text in log.txt')
    end
    else if (readStr = 'reset') then
    begin
      ResetFile(OUT_PATH);
      writeln('Reset ', OUT_PATH, ' complete.' + #10);
    end
    else writeln('Error: enter y or n' + #10);
  end;
end.