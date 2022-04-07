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
  ENC_ARR: array of string = ('ANSI', 'DOS', 'KOI8', 'UTF-8', 'UTF-16LE', 'UTF-16BE');
  
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
  UTF8_ARR: array of integer = (208, 176, 208, 177, 208, 178, 208, 179, 208, 180, 
  208, 181, 209, 145, 208, 182, 208, 183, 208, 184, 208, 185, 208, 186, 208, 187,
  208, 188, 208, 189, 208, 190, 208, 191, 209, 128, 209, 129, 209, 130, 209, 131, 
  209, 132, 209, 133, 209, 134, 209, 135, 209, 136, 209, 137, 209, 138, 209, 139, 
  209, 140, 209, 141, 209, 142, 209, 143, 208, 144, 208, 145, 208, 146, 208, 147,
  208, 148, 208, 149, 208, 129, 208, 150, 208, 151, 208, 152, 208, 153, 208, 154,
  208, 155, 208, 156, 208, 157, 208, 158, 208, 159, 208, 160, 208, 161, 208, 162, 
  208, 163, 208, 164, 208, 165, 208, 166, 208, 167, 208, 168, 208, 169, 208, 170,
  208, 171, 208, 172, 208, 173, 208, 174, 208, 175);
  ///utf16le
  UTF16LE_ARR: array of integer = (255, 254, 48, 4, 49, 4, 50, 4, 51, 4, 52, 4, 53, 
  4, 81, 4, 54, 4, 55, 4, 56, 4, 57, 4, 58, 4, 59, 4, 60, 4, 61, 4, 62, 4, 63, 4, 
  64, 4, 65, 4, 66, 4, 67, 4, 68, 4, 69, 4, 70, 4, 71, 4, 72, 4, 73, 4, 74, 4, 75,
  4, 76, 4, 77, 4, 78, 4, 79, 4, 16, 4, 17, 4, 18, 4, 19, 4, 20, 4, 21, 4, 1, 4, 
  22, 4, 23, 4, 24, 4, 25, 4);
  ///utf16be
  UTF16BE_ARR: array of integer = (254, 255, 4, 48, 4, 49, 4, 50, 4, 51, 4, 52, 4, 
  53, 4, 81, 4, 54, 4, 55, 4, 56, 4, 57, 4, 58, 4, 59, 4, 60, 4, 61, 4, 62, 4, 63,
  4, 64, 4, 65, 4, 66, 4, 67, 4, 68, 4, 69, 4, 70, 4, 71, 4, 72, 4, 73, 4, 74, 4,
  75, 4, 76, 4, 77, 4, 78, 4, 79, 4, 16, 4, 17, 4, 18, 4, 19, 4, 20, 4, 21, 4, 1,
  4, 22, 4, 23, 4, 24, 4, 25, 4);

var
  ///text var
  tfIn, tfOut, tf: TextFile;
  ///arrays
  scalesArr: array of integer; 
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

///scoring points for the correct encoding / начисление баллов за верную кодировку
procedure Scales(name: string);
begin
  //передаем массив по которому смотрим, передаем ссылку на массив в котором будут значения кодировок, 
end;

///main / основная
begin
  //вывод в файл и в консоль байт кодов файлов
  ResetFile(OUT_PATH);
  FileToBytePrint('dataANSI.txt');
  FileToBytePrint('dataDOS.txt');
  FileToBytePrint('dataUTF8.txt');
  FileToBytePrint('dataUTF16LE.txt');
  FileToBytePrint('dataKOI8.txt');
  FileToBytePrint('dataUTF16BE.txt');
  
  //запись в байт массив файла
  fileName := 'dataANSI.txt';
  FileToByteArr(fileName);
  
  readln;
end.