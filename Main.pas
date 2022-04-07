program NoExam;

//if free pascal / если фри паскаль - раскомментить
uses windows, sysutils, classes;

const
  ///folder with text files / папка с текстовыми файлами
  //rename to your / переделать на свой
  IN_PATH = 'C:\Users\as44s\Desktop\Study\Pascal\NoExam\In_Files\';
  
  ///console file / файл того что в консоли
  //rename to your / переделать на свой
  OUT_PATH = 'C:\Users\as44s\Desktop\Study\Pascal\NoExam\Out_Files\Out1.txt';
  
  ///arrays / массивы
  ///encoding name array / массив названий кодировок
  //Добавлять по необходимости и с новыми кодировками
  ENC_ARR: array of string = ('ANSI', 'DOS', 'KOI8', 'UTF-8 (UNICODE)', 'UTF-16LE (UNICODE)', 'UTF-16BE (UNICODE)');
  
  ///ansi
  ANSI_ARR: array of integer = (224, 225, 226, 227, 228, 229, 184, 230, 231, 232, 
  233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 
  249, 250, 251, 252, 253, 254, 255, 192, 193, 194, 195, 196, 197, 168, 198, 199, 
  200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 
  216, 217, 218, 219, 220, 221, 222, 223);
  ///dos
  DOS_ARR: array of integer = (63);
  ///koi8
  KOI8_ARR: array of integer = (193, 194, 215, 199, 196, 197, 163, 214, 218, 201, 
  202, 203, 204, 205, 206, 207, 208, 210, 211, 212, 213, 198, 200, 195, 222, 219, 
  221, 223, 217, 216, 220, 192, 209, 225, 226, 247, 231, 228, 229, 179, 246, 250,
  233, 234, 235, 236, 237, 238, 239, 240, 242, 243, 244, 245, 230, 232, 227, 254, 
  251, 253, 255, 249, 248, 252, 224, 241);
  ///utf8
  UTF8_ARR: array of integer = (208, 209);
  ///utf16le
  UTF16LE_ARR: array of integer = (255, 254);
  ///utf16be
  UTF16BE_ARR: array of integer = (254, 255);

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
        Print(intToStr(ord(s[i])) + ', ')
      else Print(intToStr(ord(s[i])))
    end;
  end;
  
  close(tf);
  Println('');
end;

///byte code of characters in the file, and print / байт код символов в файле, и печатает
procedure FileToByteArr(name: string);
var
  temp: string;
  i: integer;
begin
  assign(tf, IN_PATH + name);
  
  Println('');
  Println('Read file, and write to byteArr: ' + IN_PATH + name);
  
  reset(tf);
  while not eof(tf) do
  begin
    readln(tf, temp);
    
    i := 0;
    setLength(byteArr, 0);
    setLength(byteArr, length(temp) + 1);
    while (i < length(temp)) do
    begin
      inc(i);
      byteArr[i] := integer(ord(temp[i])); // сделать массив 
    end;
  end;
  
  //вывод байт массива для отладки
  i := 0;
  while (i < length(byteArr) - 1) do
  begin
    inc(i);
    if (i <> length(byteArr) - 1) then
      Print(intToStr(byteArr[i]) + ' ')
    else Print(intToStr(byteArr[i]));
  end;
  
  close(tf);
  Println('');
  Println('Done.');
end;

///adding weight by encoding / добавление веса по кодировкам
procedure WeightAdd(sclId: integer; arr: array of integer);
var
  i, j: integer;
begin
  i := 0;
  while (i < length(byteArr) - 1) do
  begin
    inc(i);
    j := 0;
    while (j < length(arr)) do
    begin
      if (byteArr[i] = arr[j]) then 
      begin
        inc(sclArr[sclId]);
        break;
      end;
      inc(j);
    end;
  end;
end;

///scoring points for the correct encoding / начисление баллов за верную кодировку
procedure SetScales();
begin
  setLength(sclArr, 0);
  setLength(sclArr, length(ENC_ARR) + 1);
  
  //если это кодировка UTF16LE
  if (length(byteArr) > 1) then
  begin
    if (byteArr[1] = UTF16LE_ARR[0]) and (byteArr[2] = UTF16LE_ARR[1]) then 
    begin
      sclArr[5] := 1;
      exit;
    end;
    //если это кодировка UTF16BE
    if (byteArr[1] = UTF16BE_ARR[0]) and (byteArr[2] = UTF16BE_ARR[1]) then 
    begin
      sclArr[6] := 1;
      exit;
    end;
  end;
  
  
  //ANSI
  WeightAdd(1, ANSI_ARR);
  //DOS
  WeightAdd(2, DOS_ARR);
  //KOI
  WeightAdd(3, KOI8_ARR);
  //UTF8
  WeightAdd(4, UTF8_ARR);
end;

///main / основная
begin
  //вывод в файл и в консоль байт кодов файлов
  ResetFile(OUT_PATH);
  //  FileToBytePrint('dataANSI.txt');
  //  FileToBytePrint('dataDOS.txt');
  //  FileToBytePrint('dataKOI8.txt');
  //  FileToBytePrint('dataUTF8.txt');
  //  FileToBytePrint('dataUTF16LE.txt');
  //  FileToBytePrint('dataUTF16BE.txt');
  
    //запись в байт массив файла
  //  fileName := 'dataANSI.txt';
  //  FileToByteArr(fileName);
  
  FileToByteArr('dataANSI.txt');
  SetScales();
  Println(intToStr(sclArr[1]) + ' ' + intToStr(sclArr[2]) + ' ' + intToStr(sclArr[3]) + ' ' + intToStr(sclArr[4]) + ' ' + intToStr(sclArr[5]) + ' ' + intToStr(sclArr[6]));
  
  FileToByteArr('dataDOS.txt');
  SetScales();
  Println(intToStr(sclArr[1]) + ' ' + intToStr(sclArr[2]) + ' ' + intToStr(sclArr[3]) + ' ' + intToStr(sclArr[4]) + ' ' + intToStr(sclArr[5]) + ' ' + intToStr(sclArr[6]));
  
  FileToByteArr('dataKOI8.txt');
  SetScales();
  Println(intToStr(sclArr[1]) + ' ' + intToStr(sclArr[2]) + ' ' + intToStr(sclArr[3]) + ' ' + intToStr(sclArr[4]) + ' ' + intToStr(sclArr[5]) + ' ' + intToStr(sclArr[6]));
  
  FileToByteArr('dataUTF8.txt');
  SetScales();
  Println(intToStr(sclArr[1]) + ' ' + intToStr(sclArr[2]) + ' ' + intToStr(sclArr[3]) + ' ' + intToStr(sclArr[4]) + ' ' + intToStr(sclArr[5]) + ' ' + intToStr(sclArr[6]));
  
  FileToByteArr('dataUTF16LE.txt');
  SetScales();
  Println(intToStr(sclArr[1]) + ' ' + intToStr(sclArr[2]) + ' ' + intToStr(sclArr[3]) + ' ' + intToStr(sclArr[4]) + ' ' + intToStr(sclArr[5]) + ' ' + intToStr(sclArr[6]));
  
  FileToByteArr('dataUTF16BE.txt');
  SetScales();
  Println(intToStr(sclArr[1]) + ' ' + intToStr(sclArr[2]) + ' ' + intToStr(sclArr[3]) + ' ' + intToStr(sclArr[4]) + ' ' + intToStr(sclArr[5]) + ' ' + intToStr(sclArr[6]));
  
  
  readln;
end.