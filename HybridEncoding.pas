///Develop by Sergeev Andrey, Gavrilov Matvey, Yaurov Gleb
///NSTU IST I-02, 2022
///Разработано Сергеевым Андреем, Гавриловым Матвеем, Яуровым Глебом
///НГТУ ИСТ И-02, 2022
///
///Transfer and assignment of rights to other persons is PROHIBITED!
///Передача и присвоение прав другим лицам - ЗАПРЕЩЕНА!

program HybridEncoding;

uses 
  ///Systems
  //if free pascal / если фри паскаль - раскомментить
  Windows, SysUtils, Classes,
  ///My
  FilesTools, CheckUTF16;

const
  ///folder with text files / папка с текстовыми файлами
  //rename to your / переделать на свой
  IN_PATH = 'C:\Users\as44s\Desktop\Study\Pascal\NoExam\In_Files\';
  
  ///console file / файл того что в консоли
  //rename to your / переделать на свой
  OUT_PATH = 'C:\Users\as44s\Desktop\Study\Pascal\NoExam\Out_Files\LogHybrid.txt';

var
  ///text var
  tfIn, tf: TextFile;
  ///arrays
  sclMtrx: array of array of integer = ((1, 2), (1, 2)); 
  byteArr: array of integer; 
  ///other var
  fileName: string;

///byte code of characters in the file / байт код символов в файле
procedure GetByteArrFromFile(name: string);
var
  temp, s: string;
  i: integer;
begin
  Println(OUT_PATH, 'Read file, and write to byteArr: ' + IN_PATH + name);
  assign(tf, IN_PATH + name);
  
  //сканирование файла
  reset(tf);
  s := '';
  while not eof(tf) do
  begin
    readln(tf, temp);
    s := s + temp;
  end;
  
  //вычисление байт массива
  i := 0;
  setLength(byteArr, 0);
  setLength(byteArr, length(s) + 1);
  while (i < length(s)) do
  begin
    inc(i);
    byteArr[i] := integer(ord(s[i])); // сделать массив 
  end;
  
  close(tf);
  Println(OUT_PATH, 'Done.');
end;

///getting encoding by byteArr / получение кодировки по byteArr
function GetEncode() : string;
begin
  ///hybrid definition. / гибридное определение.
  ///method of scales and regular sorting is combined
  ///совмещается метод весов и закономерных сортировок

  ///check UTF16LE
  if (IsUTF16LE(byteArr)) then
  begin
    GetEncode := 'UTF-16LE (100%) (by PARrotPAscal)';
    exit;
  end;
  ///check UTF16BE
  if (IsUTF16BE(byteArr)) then
  begin
    GetEncode := 'UTF-16BE (100%) (by PARrotPAscal)';
    exit;
  end;

  // сделать функцию кодировок, которая будет вызывать все нужные и возвращать имя
  // кодировки. начислять баллы - за обычные совпадения просто сделать 1 балл, за 
  // последовательности 2 балла (если 208 или 209 то если через одну будет также,то 2 балла, проверять на длинну.)
  // ЗАпихуянить в модуль?
end;

///main / основная
begin
  //цикл, если ничего не ввел то вфйти из программы, написать ему об этом, иначе выполнить код и отступ в конце и всё по кругу)
  ResetFile(OUT_PATH); //сбросить файл вывода
  //попросить ввести пользователя имя файла (описать как и где)
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
end.