///Develop by Sergeev Andrey, Gavrilov Matvey, Yaurov Gleb
///NSTU IST I-02, 2022
///Разработано Сергеевым Андреем, Гавриловым Матвеем, Яуровым Глебом
///НГТУ ИСТ И-02, 2022
///
///Transfer and assignment of rights to other persons is PROHIBITED!
///Передача и присвоение прав другим лицам - ЗАПРЕЩЕНА!

unit CheckScales;

interface

uses SysUtils, Math, Localization;

const 
  //абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
  ///rate alphabet/ частотность алфавита
  RATE_ARR: array of real = (8.01, 1.59, 4.54, 1.70, 2.98, 8.45, 0.04, 0.94, 1.65,
  7.35, 1.21, 3.49, 4.40, 3.21, 6.70, 10.97, 2.81, 4.73, 5.47, 6.26, 2.62, 0.26,
  0.97, 0.48, 1.44, 0.73, 0.36, 0.04, 1.90, 1.74, 0.32, 0.64, 2.01, 8.01, 1.59, 
  4.54, 1.70, 2.98, 8.45, 0.04, 0.94, 1.65, 7.35, 1.21, 3.49, 4.40, 3.21, 6.70,
  10.97, 2.81, 4.73, 5.47, 6.26, 2.62, 0.26, 0.97, 0.48, 1.44, 0.73, 0.36, 0.04,
  1.90, 1.74, 0.32, 0.64, 2.01);
  
  ///names / названия
  ENC_ARR: array of string = ('ANSI', 'DOS', 'KOI8');
  ENC_MTRX: array of array of integer = 
  ///ansi
  ((224, 225, 226, 227, 228, 229, 184, 230, 231, 232, 233, 234, 235, 236, 237, 238,
  239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254,
  255, 192, 193, 194, 195, 196, 197, 168, 198, 199, 200, 201, 202, 203, 204, 205,
  206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221,
  222, 223),
  ///dos
  (63), 
  ///koi8
  (193, 194, 215, 199, 196, 197, 163, 214, 218, 201, 202, 203, 204, 205, 206, 207,
  208, 210, 211, 212, 213, 198, 200, 195, 222, 219, 221, 223, 217, 216, 220, 192,
  209, 225, 226, 247, 231, 228, 229, 179, 246, 250, 233, 234, 235, 236, 237, 238,
  239, 240, 242, 243, 244, 245, 230, 232, 227, 254, 251, 253, 255, 249, 248, 252,
  224, 241));

var
  sclArr: array of real; 

///scales encoding / рассчет кодировки методом весов
function Scales(const arr: array of integer): string;
///for module / для модуля
procedure AddScale(id: integer; const arr: array of integer);

implementation

function Scales(const arr: array of integer): string;
var
  i, index: integer;
  maxMain, maxTemp, percent: real;
begin
  ///set length sclArr / установить размер sclArr
  setLength(sclArr, 0);
  setLength(sclArr, length(ENC_ARR));
  
  ///add scale by ENC_ARR / добавить вес по ENC_ARR
  i := 0;
  while (i < length(ENC_ARR)) do
  begin
    AddScale(i, arr);
    inc(i);
  end;
  
  ///find maxMain element and its index / найти maxMain элемент и его индекс
  i := 0;
  maxMain := 0;
  index := 0;
  while (i < length(sclArr)) do
  begin
    if (sclArr[i] > maxMain) then 
    begin
      maxMain := sclArr[i];
      index := i; 
    end;
    inc(i);
  end;
  ///find max2 element and its index / найти макс.2 элемент и его индекс
  i := 0;
  maxTemp := 0;
  while (i < length(sclArr)) do
  begin
    if ((sclArr[i] > maxTemp) and (sclArr[i] < maxMain)) then 
    begin
      maxTemp := sclArr[i]; 
    end;
    inc(i);
  end;
  
  ///is encoding supported? / поддерживается ли кодировка?
  if (maxMain < 0.0001) then 
  begin
    Scales := GetLocalization(9);
    exit;
  end;
  
  ///calculating percent encoding / найти процент кодировки
  //нахождение по сумме а не по макс1 и макс2
  //  i := 0;
  //  sum := 0;
  //  while (i < length(sclArr)) do
  //  begin
  //    sum := sum + sclArr[i];
  //    inc(i);
  //  end;
  percent := Round(((maxMain / (maxMain + maxTemp)) + 0.001) * 1000) / 10;
  if (percent > 100) then percent := 100;
  
  ///output the final str / вывести итоговую строку
  Scales := ENC_ARR[index] + ' (' + floatToStr(percent) + '%) (by NoExam)';
  
  //вывод байт массива для отладки
  i := 0;
  while (i < length(sclArr)) do
  begin
    
    if (i <> length(sclArr) - 1) then
      Write(floatToStr(sclArr[i]) + ' ')
    else Write(floatToStr(sclArr[i]));
    inc(i);
  end;
end;

procedure AddScale(id: integer; const arr: array of integer);
var
  i, j: integer;
begin
  i := 0;
  while (i < length(arr) - 1) do
  begin
    inc(i);
    j := 0;
    while (j < length(ENC_MTRX[id])) do
    begin
      if (arr[i] = ENC_MTRX[id][j]) then 
      begin
        sclArr[id] := sclArr[id] + RATE_ARR[j];
        break;
      end;
      inc(j);
    end;
  end;
end;
end.