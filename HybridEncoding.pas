﻿///Develop by Sergeev Andrey, Gavrilov Matvey, Yaurov Gleb
///NSTU IST I-02, 2022
///Разработано Сергеевым Андреем, Гавриловым Матвеем, Яуровым Глебом
///НГТУ ИСТ И-02, 2022
///
///Transfer and assignment of rights to other persons is PROHIBITED!
///Передача и присвоение прав другим лицам - ЗАПРЕЩЕНА!

program HybridEncoding;

uses 
  ///Systems
  Windows, SysUtils,
  ///NoExam
  FilesTools, CheckUTF16, CheckUTF8, CheckScales, Localization;

const
  ///folder with text files / папка с текстовыми файлами
  IN_PATH: rawbytestring  = '\In_Files\';
  
  ///console file / файл того что в консоли
  OUT_PATH: rawbytestring = '\Out_Files\LogHybrid.txt';

var
  singleByteArr, doubleByteArr: array of integer;
  fileStr: rawbytestring;

///byte code of characters in the file / байт код символов в файле
procedure GetByteArrFromFile(name: rawbytestring);
var
  tf: TextFile;
  temp, s: rawbytestring;
  ws: widestring;
  i, m, n: integer;
begin
  Println(OUT_PATH, GetLocalization(0) + IN_PATH + name);
  assign(tf, ExtractFilePath(ParamStr(0)) + IN_PATH + name);
  
  //сканирование файла
  reset(tf);
  s := '';
  while not eof(tf) do
  begin
    readln(tf, temp);
    s := s + temp;
  end;
  
  ///calculating a single byte array / вычисление одиночного байт массива
  i := 0;
  setLength(singleByteArr, 0);
  setLength(singleByteArr, length(s) + 1);
  while (i < length(s)) do
  begin
    inc(i);
    singleByteArr[i] := integer(ord(s[i])); // сделать массив 
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
  
  close(tf);
  Println(OUT_PATH, GetLocalization(1));
end;

///getting encodings / получение кодировок
function GetEncode() : rawbytestring;
begin
  ///hybrid definition. / гибридное определение.
  ///method of scales and regular sorting is combined
  ///совмещается метод весов и закономерных сортировок
  
  ///check UTF16LE
  if (IsUTF16LE(singleByteArr)) then
  begin
    GetEncode := 'UTF-16LE (100%) (by NoExam)';
    exit;
  end;
  ///check UTF16BE
  if (IsUTF16BE(singleByteArr)) then
  begin
    GetEncode := 'UTF-16BE (100%) (by NoExam)';
    exit;
  end;
  //не найдена
  Println(OUT_PATH, GetLocalization(7));
  ///check UTF8
  if (IsUTF8(doubleByteArr)) then
  begin
    GetEncode := 'UTF-8 (100%) (by NoExam)';
    exit;
  end;
  //не найдена
  Println(OUT_PATH, GetLocalization(8));
  
  GetEncode := Scales(singleByteArr);
  
  // сделать функцию кодировок, которая будет вызывать все нужные и возвращать имя
  // кодировки. начислять баллы - за обычные совпадения просто сделать 1 балл, за 
  // последовательности 2 балла (если 208 или 209 то если через одну будет также,то 2 балла, проверять на длинну.)
  // ЗАпихуянить в модуль?
end;

procedure UserTest();
var
  s: rawbytestring;
  i: integer;
begin
  ///reset log file / сброс файла логов
  ResetFile(OUT_PATH);
  
  //    /// select language interface / выбор языка интерфейса
  //  while (true) do
  //  begin
  //    Println(OUT_PATH, 'Select language: ru or en');
  //    readln(s);
  //    writeln(' ');
  //    if (AnsiPos('en', ' ' + s) <> 0) then
  //    begin
  //      locale := en;
  //      break;
  //    end
  //    else if (AnsiPos('ru', ' ' + s) <> 0) then 
  //    begin
  //      locale := ru;
  //      break;
  //    end
  //    else 
  //    begin
  //      Println(OUT_PATH, s + ' - Inccorect input. Enter ru or en');
  //      Println(OUT_PATH, ' ');
  //    end;
  //  end;
  //  //отступ
  //  Println(OUT_PATH, ' ');
  //  
  //  while (true) do
  //  begin
  //          ///how use / как использовать
  //    Println(OUT_PATH, GetLocalization(5));
  //    Println(OUT_PATH, GetLocalization(2) + IN_PATH + GetLocalization(3));
  //    Println(OUT_PATH, GetLocalization(4));
  //    readln(s);
  //    
  //      ///check exit from programm / проверка выхода из программы
  //      // if (s = '') then exit;
  //    
  //      ///checks file name / проверка имени файла
  //    if ((length(s) - AnsiPos('.txt', ' ' + s)) <> 2) then
  //    begin
  //      Println(OUT_PATH, GetLocalization(6));
  //      Println(OUT_PATH, ' ');
  //      continue;
  //    end;
  //  end;
  
    //введенное имя передать на расшифровку в байты
    //вызвать принт в котором функцию раскодировки
  
  GetByteArrFromFile('dataANSI.txt');
  Println(OUT_PATH, GetEncode());
  Println(OUT_PATH, ' ');
  GetByteArrFromFile('dataDOS.txt');
  Println(OUT_PATH, GetEncode());
  Println(OUT_PATH, ' ');
  GetByteArrFromFile('dataKOI8.txt');
  Println(OUT_PATH, GetEncode());
  Println(OUT_PATH, ' ');
  GetByteArrFromFile('dataUTF8.txt');
  Println(OUT_PATH, GetEncode());
  Println(OUT_PATH, ' ');
  GetByteArrFromFile('dataUTF16LE.txt');
  Println(OUT_PATH, GetEncode());
  Println(OUT_PATH, ' ');
  GetByteArrFromFile('dataUTF16BE.txt');
  Println(OUT_PATH, GetEncode());
  Println(OUT_PATH, ' ');
end;

///main / основная
begin
  UserTest();
  readln();
end.