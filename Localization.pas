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
  (('Info: Reading and writing file to byteArr: ',
  'Info: Done.',
  'Put file in ',
  ' and enter to console "FileName".txt',
  'To exit the program, leave the input field empty..',
  'Hello!',
  'Error: Only files with the extension .txt are supported!',
  'Info: UTF16x codepage not detected',
  'Info: UTF8 codepage not detected',
  'Error: Codepage or symbols is not supported by this program!',
  'Result: ',
  'You can always change the language with the "locale" command',
  'Error: Empty file',
  'Error: file not found',
  'The codepage does not support the Russian. Perhaps it is one of the following:'),
  ///ru
  ('Инф: Чтение файла и запись в byteArr: ', 
  'Инф: Выполненно', 
  'Поместите файл в ',
  ' и введите в консоль "ИмяФайла".txt', 
  'Для выхода из программы оставьте поле ввода пустым..',
  'Здравствуйте!', 
  'Ошибка: Поддерживаются только файлы с расширением .txt!',
  'Инф: Кодировки UTF16x не обнаружены',
  'Инф: Кодировка UTF8 не обнаружена', 
  'Ошибка: Кодировка либо символы не поддерживаются данной программой!',
  'Результат: ',
  'Вы всегда можете сменить язык командой "locale"',
  'Ошибка: пустой файл',
  'Ошибка: файл не найден',
  'Кодировка не поддерживает русский язык. Возможно это одна из:'));

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