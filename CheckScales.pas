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
  RATE_MTRX: array of array of real = 
  ((), ());
  
  ///names / названия
  ENC_ARR: array of rawbytestring = (
  'WINDOWS-1251 [1251]',
  'DOS/IBM437 [437], WINDOWS-1252 [1252], BIG5 [950], IBM865 [865]',
  'KOI8-r/KOI8-u [20866/21866]',
  'CP866 [866]',
  'IBM855 [855]',
  'ISO-8859-5 [28595]',
  'X-MAC-CYRILLIC [10007]');
  
  ENC_MTRX: array of array of integer = 
  ///1251
  ((224, 225, 226, 227, 228, 229, 184, 230, 231, 232, 233, 234, 235, 236, 237, 238,
  239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254,
  255, 192, 193, 194, 195, 196, 197, 168, 198, 199, 200, 201, 202, 203, 204, 205,
  206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221,
  222, 223),
  ///etc
  (63), 
  ///koi8-r
  (193, 194, 215, 199, 196, 197, 163, 214, 218, 201, 202, 203, 204, 205, 206, 207,
  208, 210, 211, 212, 213, 198, 200, 195, 222, 219, 221, 223, 217, 216, 220, 192,
  209, 225, 226, 247, 231, 228, 229, 179, 246, 250, 233, 234, 235, 236, 237, 238,
  239, 240, 242, 243, 244, 245, 230, 232, 227, 254, 251, 253, 255, 249, 248, 252,
  224, 241),
  ///cp866
  (160, 161, 162, 163, 164, 165, 241, 166, 167, 168, 169, 170, 171, 172, 173, 174,
  175, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238,
  239, 128, 129, 130, 131, 132, 133, 240, 134, 135, 136, 137, 138, 139, 140, 141,
  142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157,
  158, 159),
  ///ibm855
  (160, 162, 235, 172, 166, 168, 132, 233, 243, 183, 189, 198, 208, 210, 212, 214,
  216, 225, 227, 229, 231, 170, 181, 164, 251, 245, 249, 158, 241, 237, 247, 156,
  222, 161, 163, 236, 173, 167, 169, 133, 234, 244, 184, 190, 199, 209, 211, 213,
  215, 221, 226, 228, 230, 232, 171, 182, 165, 252, 246, 250, 159, 242, 238, 248,
  157, 224),
  ///iso-8859-5
  (208, 209, 210, 211, 212, 213, 241, 214, 215, 216, 217, 218, 219, 220, 221, 222,
  223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238,
  239, 176, 177, 178, 179, 180, 181, 161, 182, 183, 184, 185, 186, 187, 188, 189,
  190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205,
  206, 207),
  ///x-mac-cyrillic
  (224, 225, 226, 227, 228, 229, 222, 230, 231, 232, 233, 234, 235, 236, 237, 238,
  239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254,
  223, 128, 129, 130, 131, 132, 133, 221, 134, 135, 136, 137, 138, 139, 140, 141,
  142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157,
  158, 159));

var
  sclArr: array of real; 

///scales encoding / рассчет кодировки методом весов
function Scales(const arr: array of integer): rawbytestring;
///for module / для модуля
procedure AddScale(id: integer; const arr: array of integer);

implementation

function Scales(const arr: array of integer): rawbytestring;
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
  
  ///if 63 / если 63
  if (index = 1) then 
  begin
    Scales := GetLocalization(14) + #10 + ENC_ARR[index] + '... (by NoExam)';
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
  Scales := GetLocalization(10) + ENC_ARR[index] + ' (' + floatToStr(percent) 
    + '%) (by NoExam)';
  
  //  //вывод байт массива для отладки
  //  i := 0;
  //  while (i < length(sclArr)) do
  //  begin
  //    
  //    if (i <> length(sclArr) - 1) then
  //      Write(floatToStr(sclArr[i]) + ' ')
  //    else Write(floatToStr(sclArr[i]));
  //    inc(i);
  //  end;
end;

procedure AddScale(id: integer; const arr: array of integer);
var
  i, j, k: integer;
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
        ///rate arr
        sclArr[id] := sclArr[id] + RATE_ARR[j];
        
        ///rate mtrx
        if (i <> length(arr) - 1) then 
        begin
          k := 0;
          while (k < length(ENC_MTRX[id])) do
          begin
            if (arr[i + 1] = ENC_MTRX[id][k]) then 
            begin
              writeln(RATE_MTRX[j][k]);
              sclArr[id] := sclArr[id] + RATE_MTRX[j][k];
              break;
            end;
            inc(k);
          end;
        end;
        
        ///break
        break;
      end;
      inc(j);
    end;
  end;
end;
end.