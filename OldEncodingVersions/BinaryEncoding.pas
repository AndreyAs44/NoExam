///Develop by Sergeev Andrey, Gavrilov Matvey, Yaurov Gleb
///NSTU IST I-02, 2022
///Разработано Сергеевым Андреем, Гавриловым Матвеем, Яуровым Глебом
///НГТУ ИСТ И-02, 2022
///
///Transfer and assignment of rights to other persons is PROHIBITED!
///Передача и присвоение прав другим лицам - ЗАПРЕЩЕНА!

program BinaryEncoding;

//if free pascal / если фри паскаль - раскомментить
uses windows, sysutils, classes;

const
  ///folder with text files / папка с текстовыми файлами
  //rename to your / переделать на свой
  IN_PATH = 'C:\Users\as44s\Desktop\Study\Pascal\NoExam\In_Files\';
  
  ///console file / файл того что в консоли
  //rename to your / переделать на свой
  OUT_PATH = 'C:\Users\as44s\Desktop\Study\Pascal\NoExam\Out_Files\OutComparision.txt';
  
  ///arrays / массивы
  ///encoding name array / массив названий кодировок
  //Добавлять по необходимости и с новыми кодировками
  ENC_ARR: array of string = ('ANSI', 'DOS', 'KOI8', 'UTF-8 (UNICODE)', 'UTF-16LE (UNICODE)', 'UTF-16BE (UNICODE)');

var
  ///text var
  tfIn, tfOut, tf: TextFile;
  ///arrays
  sclArr: array of integer; 
  byteArr: array of integer; 
  ///other var
  fileName: string;

///clearing the file along the way / очистка файла по пути
procedure ResetFile(s: string);
begin
  assign(tf, s);
  rewrite(tf);
  close(tf);
end;

/// print to console and to file / печать и в консоль и в файл
procedure Print(s: string);
begin
  assign(tfOut, OUT_PATH);
  append(tfOut);
  write(s);
  write(tfOut, s);
  close(tfOut);
end;

/// print to console and to file / печать и в консоль и в файл
procedure Println(s: string);
begin
  assign(tfOut, OUT_PATH);
  append(tfOut);
  writeln(s);
  writeln(tfOut, s);
  close(tfOut);
end;

///byte code of characters in the file, and print / байт код символов в файле, и печатает
procedure FileToBytePrint(name: string);
var
  s: string;
  i: integer;
begin
  assign(tf, IN_PATH + name);
  
  Println('Read: ' + IN_PATH + name);
  reset(tf);
  while not eof(tf) do
  begin
    readln(tf, s);
    
    i := 0;
    while (i < length(s)) do
    begin
      inc(i);
      if (i <> length(s)) then
        Print(intToStr(intToBin(ord(s[i]))) + ', ')
      else Println(intToStr(intToBin(ord(s[i]))))
    end;
  end;
  
  Println(intToStr(TEncoding.UNICODE.GetPreamble()[1]));
  
  close(tf);
  Println('');
end;

///main / основная
begin
  //вывод в файл и в консоль байт кодов файлов
  ResetFile(OUT_PATH);
  FileToBytePrint('dataANSI.txt');
    FileToBytePrint('dataDOS.txt');
    FileToBytePrint('dataKOI8.txt');
    FileToBytePrint('dataUTF8.txt');
    FileToBytePrint('dataUTF16LE.txt');
    FileToBytePrint('dataUTF16BE.txt');
  
  readln;
end.