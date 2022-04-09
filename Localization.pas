///Develop by Sergeev Andrey, Gavrilov Matvey, Yaurov Gleb
///NSTU IST I-02, 2022
///Разработано Сергеевым Андреем, Гавриловым Матвеем, Яуровым Глебом
///НГТУ ИСТ И-02, 2022
///
///Transfer and assignment of rights to other persons is PROHIBITED!
///Передача и присвоение прав другим лицам - ЗАПРЕЩЕНА!

unit Localization;

interface

uses Windows;

///Localization table / таблица локализации
const
  en = 0;
  ru = 1;

  L_TABLE: array of array of rawbytestring = 
  ///en
  (('Read file, and write to byteArr: ', 
  'Done.', 
  'Put the file in ',
  ' and write FileName.txt', 
  'To exit the program, leave the input field empty..',
  'Hello!', 
  'Only files with the extension are supported .txt!'),
  ///ru
  ('Чтение файла и запись в byteArr: ', 
  'Выполненно', 
  'Поместите файл в  ',
  ' и напишите ИмяФайла.txt', 
  'Для выхода из программы оставьте поле ввода пустым..',
  'Здравствуйте!', 
  'Поддерживаются только файлы с расширением .txt!'));

var
  locale: integer;

///получение текста локализации по индексу матрицы
///getting localization text by matrix index
function GetLocalization(l: integer): rawbytestring;

implementation 

function GetLocalization(l: integer): rawbytestring;
begin
  ///check locale 
  if ((locale <> en) and (locale <> ru)) then locale := 0;
  ///get value
  GetLocalization := L_TABLE[locale][l];
end;
end.