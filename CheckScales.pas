///Develop by Sergeev Andrey, Gavrilov Matvey, Yaurov Gleb
///NSTU IST I-02, 2022
///Разработано Сергеевым Андреем, Гавриловым Матвеем, Яуровым Глебом
///НГТУ ИСТ И-02, 2022
///
///Transfer and assignment of rights to other persons is PROHIBITED!
///Передача и присвоение прав другим лицам - ЗАПРЕЩЕНА!

unit CheckScales;

interface

const 
  //абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
  ///rate alphabet/ частотность алфавита
  RATE_ARR: array of real = (8.01, 1.59, 4.54, 1.70, 2.98, 8.45, 0.04, 0.94, 1.65,
  7.35, 1.21, 3.49, 4.40, 3.21, 6.70, 10.97, 2.81, 4.73, 5.47, 6.26, 2.62, 0.26,
  0.97, 0.48, 1.44, 0.73, 0.36, 0.04, 1.90, 1.74, 0.32, 0.64, 2.01, 8.01, 1.59, 
  4.54, 1.70, 2.98, 8.45, 0.04, 0.94, 1.65, 7.35, 1.21, 3.49, 4.40, 3.21, 6.70,
  10.97, 2.81, 4.73, 5.47, 6.26, 2.62, 0.26, 0.97, 0.48, 1.44, 0.73, 0.36, 0.04,
  1.90, 1.74, 0.32, 0.64, 2.01);
  ///rating for utf 8 sequences / рейтинг для последовательностей utf8
  RATE_UTF8_ARR: array of real = (15, 10, 5.47, 4.73);
  ///names / названия
  ENC_ARR: array of string = ('ANSI', 'DOS', 'KOI8', 'UTF-8 (UNICODE)');
  
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

var
  sclArr: array of real;
//добавить функции 

///scales encoding / рассчет кодировки методом весов
function Scales(const arr: array of integer): string;
///for module / для модуля
procedure AddScaleUtf8(const arr: array of integer);

implementation

function Scales(const arr: array of integer): string;
begin
  AddScaleUtf8(arr);
  Scales := 'sc';
  //вернуть строку с кодировкой и процентами
end;

procedure AddScaleUtf8(const arr: array of integer);
var
  i, j: integer;
begin
  i := 0;
  while (i < length(arr) - 1) do
  begin
    inc(i);
//    if ((length(arr) - 1 - i) >= 3) the
  end;
end;
end.